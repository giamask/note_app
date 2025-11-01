import 'package:flutter/material.dart';

/// Icon ideentifiers for the app.
@immutable
class AppIcons {
  const AppIcons._();

  static const arrowBack = Icon(Icons.arrow_back_rounded);

  //=> Darawer Icon
  static const pen = Icon(Icons.mode_edit_outline_rounded);
  static const archive = Icon(Icons.archive_rounded);
  static const trash = Icon(Icons.delete);
  static const setting = Icon(Icons.settings);

  //=> SearchBar Icon
  static const menu = Icon(Icons.menu_sharp);
  static const grip = Icons.view_agenda_outlined;
  static const gripVertical = Icons.grid_view_outlined;
  static const searchNote = Icon(Icons.search);

  //=> Home Page
  static const add = Icon(Icons.add);

  //=> Note Page
  static const archiveNote = Icon(Icons.archive_outlined);
  static const unarchiveNote = Icon(Icons.unarchive_outlined);

  static const pin = Icons.push_pin_rounded;
  static const unPin = Icons.push_pin_outlined;

  static const rede = Icon(Icons.redo);
  static const undo = Icon(Icons.undo);

  static const more = Icon(Icons.more_vert_outlined);
  static const drawColor = Icon(Icons.color_lens_outlined);

  static const addReminder = Icon(Icons.notification_add_outlined);

  static const defuaulCheckColor = Icon(Icons.format_color_reset_outlined);
  static const check = Icon(Icons.check_rounded, color: Colors.blueAccent);

  static const trashNote = Icon(Icons.delete_outline_rounded);
  static const sendNote = Icon(Icons.share_sharp);

  static const deleteNote = Icon(Icons.delete_forever_outlined);
  static const restoreNote = Icon(Icons.restore);

  static const themes = Icon(Icons.color_lens_outlined);
  static const scanDocument = Icon(Icons.document_scanner_outlined);

  // Empty Notes
  static const emptySearch = Icon(Icons.search, size: 100);
  static Image emptyNote = Image.asset('assets/image/ox_bg.png', height: 130,width: 130,);
  static const emptyArchivesNote = Icon(Icons.archive_outlined, size: 150);
  static const emptyTrashNote = Icon(Icons.delete_outline_rounded, size: 150);

  // Error Notes
  static const error = Icon(Icons.error_outline_outlined, size: 150);

  static final List<String> profiles = [
    'assets/image/calendar17.jpg',
    'assets/image/calendar18.jpg',
    'assets/image/calendar19.jpg',
    'assets/image/calendar20.jpg',
    'assets/image/calendar21.jpg',
    'assets/image/calendar22.jpg',
    'assets/image/calendar23.jpg',
    'assets/image/calendar24.jpg',
    'assets/image/calendar25.jpg',
    'assets/image/calendar26.jpg',
  ].reversed.toList();
}
