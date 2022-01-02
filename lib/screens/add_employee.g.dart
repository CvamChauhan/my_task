// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_employee.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddEmployeeAdapter extends TypeAdapter<AddEmployee> {
  @override
  final int typeId = 0;

  @override
  AddEmployee read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddEmployee(
      name: fields[0] as String,
      age: fields[1] as String,
      gender: fields[2] as String,
    )..isSignIn = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, AddEmployee obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.isSignIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddEmployeeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
