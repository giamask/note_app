import 'dart:io';

import '../../domain/entities/note.dart';

class NoteModel extends Note {
  final List<String>? imagePaths;

  @override
  List<File> get images =>
      throw UnimplementedError('Images not defined in NoteModel');

  const NoteModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.colorIndex,
      required super.modifiedTime,
      required super.stateNote,
      this.imagePaths});
}
