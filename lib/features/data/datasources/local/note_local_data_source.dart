import 'package:dartz/dartz.dart';

import '../../model/note_model.dart';

abstract class NoteLocalDataSource {
  Future<bool> initDb();
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel> getNoteById(String noteModelById);
  Future<Unit> addNote(NoteModel noteModel);
  Future<Unit> updateNote(NoteModel noteModel);
  Future<Unit> deleteNote(String noteModelId);
}
