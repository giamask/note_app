import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime modifiedTime;
  final int colorIndex;
  final StatusNote stateNote;
  final List<File> images;

  const Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.colorIndex,
      required this.modifiedTime,
      required this.stateNote,
      this.images = const []});

  // Define the copyWith method here
  Note copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? modifiedTime,
    int? colorIndex,
    StatusNote? statusNote,
    List<File>? images,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorIndex: colorIndex ?? this.colorIndex,
      modifiedTime: modifiedTime ?? this.modifiedTime,
      stateNote: statusNote ?? stateNote,
      images: images ?? this.images,
    );
  }

  Note.empty({
    String? id,
    this.title = '',
    this.content = '',
    DateTime? modifiedTime,
    this.colorIndex = 0,
    this.stateNote = StatusNote.undefined,
    this.images = const [],
  })  : id = id ?? UUIDGen.generate(),
        modifiedTime = modifiedTime ?? DateTime.now();

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        colorIndex,
        modifiedTime,
        stateNote,
        ...(images.map((x) => x.hashCode))
      ];
}
