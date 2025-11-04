import 'dart:io';
import 'package:note_app/AppPath.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Resolves old absolute iOS paths to the current container.
File? resolveStalePath(String storedAbsPath) {
  if (File(storedAbsPath).existsSync()) return File(storedAbsPath);

  final newBase = AppPath.documentsDir;
  const marker = '/Documents/';
  final idx = storedAbsPath.indexOf(marker);
  if (idx != -1) {
    final tail = storedAbsPath.substring(idx + marker.length);
    final remap = p.join(newBase, tail);
    final file = File(remap);
    if (file.existsSync()) {
      return file;
    }
  }
  return null;
}