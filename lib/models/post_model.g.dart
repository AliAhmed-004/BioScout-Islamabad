// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 0;

  @override
  PostModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostModel(
      id: fields[0] as String,
      speciesName: fields[1] as String?,
      aiSuggested: fields[2] as bool,
      dateObserved: fields[3] as DateTime,
      location: fields[4] as String,
      imageUrl: fields[5] as String,
      notes: fields[6] as String,
      timestamp: fields[7] as DateTime,
      userId: fields[8] as String,
      likedByUserIds: (fields[9] as List).cast<String>(),
      comments: (fields[10] as List).cast<CommentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.speciesName)
      ..writeByte(2)
      ..write(obj.aiSuggested)
      ..writeByte(3)
      ..write(obj.dateObserved)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.timestamp)
      ..writeByte(9)
      ..write(obj.likedByUserIds)
      ..writeByte(10)
      ..write(obj.comments)
      ..writeByte(8)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
