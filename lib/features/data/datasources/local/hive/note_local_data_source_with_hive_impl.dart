import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/core/core.dart';
import 'package:note_app/features/data/datasources/local/hive/reminder_hive.dart';
import 'package:path_provider/path_provider.dart';

import 'note_hive.dart';
import '../note_local_data_source.dart';
import '../../../model/note_model.dart';
import 'state_note_hive.dart';

class NoteLocalDataSourceWithHiveImpl implements NoteLocalDataSource {
  final String _boxNote = 'note_box';
  @override
  Future<bool> initDb() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(NoteHiveAdapter());
      Hive.registerAdapter(StateNoteHiveAdapter());
      Hive.registerAdapter(ReminderHiveAdapter());

      await Hive.openBox<NoteHive>(_boxNote);
      return true;
    } catch (_) {
      throw ConnectionException();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);

      final List<NoteModel> resultNotes = noteBox.values
          .map(
            (note) => NoteModel(
                id: note.id,
                title: note.title,
                content: note.content,
                colorIndex: note.colorIndex,
                modifiedTime: note.modifiedTime,
                stateNote: note.stateNoteHive.stateNote,
                reminders: note.reminders.map((r) => r.reminder).toList(),
                imagePaths: note.imagePaths),
          )
          .toList();
      return resultNotes;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<NoteModel> getNoteById(String noteModelById) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);

      final NoteHive resultNote = noteBox.values.firstWhere(
        (element) => element.id == noteModelById,
      );

      return NoteModel(
          id: resultNote.id,
          title: resultNote.title,
          content: resultNote.content,
          colorIndex: resultNote.colorIndex,
          modifiedTime: resultNote.modifiedTime,
          stateNote: resultNote.stateNoteHive.stateNote,
          reminders: resultNote.reminders.map((r) => r.reminder).toList(),
          imagePaths: resultNote.imagePaths);
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> addNote(NoteModel noteModel) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      final noteKey = noteModel.id;

      final NoteHive noteHive = NoteHive(
          id: noteModel.id,
          title: noteModel.title,
          content: noteModel.content,
          colorIndex: noteModel.colorIndex,
          modifiedTime: noteModel.modifiedTime,
          stateNoteHive: noteModel.stateNote.stateNoteHive,
          reminders: noteModel.reminders.map((r) => r.reminderHive).toList(),
          imagePaths: noteModel.imagePaths);
      await noteBox.put(noteKey, noteHive);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> updateNote(NoteModel noteModel) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      final indexNoteId = noteModel.id;

      final previousNote = noteBox.get(indexNoteId);

      for (final path in previousNote?.imagePaths ?? []) {
        if (noteModel.imagePaths != null &&
            !noteModel.imagePaths!.contains(path)) {
          await File(path).delete();
        }
      }

      final NoteHive noteHive = NoteHive(
          id: noteModel.id,
          title: noteModel.title,
          content: noteModel.content,
          colorIndex: noteModel.colorIndex,
          modifiedTime: noteModel.modifiedTime,
          stateNoteHive: noteModel.stateNote.stateNoteHive,
          reminders: noteModel.reminders
              .map((reminder) => reminder.reminderHive)
              .toList(),
          imagePaths: noteModel.imagePaths);
      await noteBox.put(indexNoteId, noteHive);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }

  @override
  Future<Unit> deleteNote(String noteModelId) async {
    try {
      final noteBox = Hive.box<NoteHive>(_boxNote);
      final imagesPaths = noteBox.get(noteModelId)?.imagePaths;
      //Delete images as well
      if (imagesPaths != null) {
        for (var imagePath in imagesPaths) {
          await File(imagePath).delete();
        }
      }
      await noteBox.delete(noteModelId);
      return unit;
    } catch (_) {
      throw NoDataException();
    }
  }
}
