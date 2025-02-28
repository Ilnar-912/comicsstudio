// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawing_point.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DrawingPointAdapter extends TypeAdapter<DrawingPoint> {
  @override
  final int typeId = 1;

  @override
  DrawingPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrawingPoint(
      point: fields[0] as Offset,
      color: fields[1] as Color,
      strokeWidth: fields[2] as double,
      brushType: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DrawingPoint obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.point)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.strokeWidth)
      ..writeByte(3)
      ..write(obj.brushType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrawingPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
