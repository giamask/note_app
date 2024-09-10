import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/local/note_local_data_source.dart';
import '../model/note_model.dart';

class NoteRepositoriesImpl implements NoteRepositories {
  final NoteLocalDataSource noteLocalDataSourse;

  NoteRepositoriesImpl({
    required this.noteLocalDataSourse,
  });

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final response = await noteLocalDataSourse.getAllNotes();
      final notes = response
          .map((x) => Note(
                id: x.id,
                title: x.title,
                content: x.content,
                colorIndex: x.colorIndex,
                modifiedTime: x.modifiedTime,
                stateNote: x.stateNote,
                images: x.imagePaths?.map((x) => File(x)).toList() ?? [],
              ))
          .toList();

      return Right(notes);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> getNoteById(String noteId) async {
    try {
      final response = await noteLocalDataSourse.getNoteById(noteId);
      final Note convertToNote = Note(
        id: response.id,
        title: response.title,
        content: response.content,
        colorIndex: response.colorIndex,
        modifiedTime: response.modifiedTime,
        stateNote: response.stateNote,
        images: response.imagePaths?.map((x) => File(x)).toList() ?? [],
      );
      return Right(convertToNote);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    try {
      if (note.title.isEmpty && note.content.isEmpty) {
        return Left(EmpytInputFailure());
      } else {
        final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          colorIndex: note.colorIndex,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
          imagePaths: note.images.map((x) => x.path).toList(),
        );
        await noteLocalDataSourse.addNote(convertToNoteModel);
        return const Right(unit);
      }
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    try {
      final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          colorIndex: note.colorIndex,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
          imagePaths: note.images.map((x) => x.path).toList());
      await noteLocalDataSourse.updateNote(convertToNoteModel);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String noteId) async {
    try {
      await noteLocalDataSourse.deleteNote(noteId);
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  // Future<Either<Failure, T>> executeAndHandleError<T>(
  //   Future<T> Function() function,
  // ) async {
  //   try {
  //     final result = await function();
  //     return Right(result);
  //   } on NoDataException {
  //     return Left(NoDataFailure());
  //   }
  // }
}
