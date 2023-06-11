// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      ChatUser.fromJson(json['author'] as Map<String, dynamic>),
      DateTime.parse(json['time'] as String),
      json['text'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'author': instance.author,
      'time': instance.time.toIso8601String(),
      'text': instance.text,
    };
