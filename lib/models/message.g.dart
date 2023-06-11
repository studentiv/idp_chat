// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      json['time'] as int,
      json['text'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'author': instance.author,
      'time': instance.time,
      'text': instance.text,
    };
