// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_db.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class LinkDataAdapter extends TypeAdapter<LinkData> {
  @override
  final typeId = 0;

  @override
  LinkData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinkData(
      id: fields[0] as String,
      url: fields[1] as String,
      title: fields[2] as String?,
      description: fields[3] as String?,
      image: fields[8] as String?,
      siteName: fields[9] as String?,
      tag: fields[4] as String?,
      isSynced: fields[5] == null ? false : fields[5] as bool,
      isPinned: fields[6] == null ? false : fields[6] as bool,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[10] as DateTime,
      aiSummary: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LinkData obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.tag)
      ..writeByte(5)
      ..write(obj.isSynced)
      ..writeByte(6)
      ..write(obj.isPinned)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.siteName)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.aiSummary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
