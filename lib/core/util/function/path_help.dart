// lib/core/file_paths.dart
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> docsBase() async => (await getApplicationDocumentsDirectory()).path;

/// Join base + relative. If `stored` is already absolute, just return it.
Future<String> toAbsolute(String stored) async {
  if (p.isAbsolute(stored)) return stored;
  return p.join(await docsBase(), stored);
}

/// Build a relative path where we store images: images/<noteId>/<fileName>
String relImagePath(String noteId, String fileName) =>
    p.join('images', noteId, fileName);
