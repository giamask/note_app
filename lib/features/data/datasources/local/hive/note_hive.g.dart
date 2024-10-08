// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHiveAdapter extends TypeAdapter<NoteHive> {
  @override
  final int typeId = 0;

  @override
  NoteHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    List reminders = [];
    if (fields[7] != null) {
      reminders = fields[7];
    }
    return NoteHive(
      id: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      colorIndex: fields[3] as int,
      modifiedTime: fields[4] as DateTime,
      stateNoteHive: fields[5] as StateNoteHive,
      reminders: (reminders).cast<ReminderHive>(),
      imagePaths: (fields[6] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, NoteHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.colorIndex)
      ..writeByte(4)
      ..write(obj.modifiedTime)
      ..writeByte(5)
      ..write(obj.stateNoteHive)
      ..writeByte(7)
      ..write(obj.reminders)
      ..writeByte(6)
      ..write(obj.imagePaths);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
