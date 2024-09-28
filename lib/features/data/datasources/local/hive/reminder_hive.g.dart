// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderHiveAdapter extends TypeAdapter<ReminderHive> {
  @override
  final int typeId = 3;

  @override
  ReminderHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderHive(
      id: fields[0] as int,
      dateTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
