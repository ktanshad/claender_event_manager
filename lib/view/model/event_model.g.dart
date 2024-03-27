// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 0;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      nativeEventId: fields[0] as String?,
      index: fields[1] as int?,
      title: fields[2] as String?,
      appointmentStartDate: fields[3] as DateTime,
      appointmentEndDate: fields[4] as DateTime,
      isAllDay: fields[6] as bool,
      detail: fields[7] as String,
      repeatOption: fields[8] as String?,
      eventData: fields[9] as Object?,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.nativeEventId)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.appointmentStartDate)
      ..writeByte(4)
      ..write(obj.appointmentEndDate)
      ..writeByte(6)
      ..write(obj.isAllDay)
      ..writeByte(7)
      ..write(obj.detail)
      ..writeByte(8)
      ..write(obj.repeatOption)
      ..writeByte(9)
      ..write(obj.eventData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
