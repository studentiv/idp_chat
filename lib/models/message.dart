import 'package:json_annotation/json_annotation.dart';

import 'chat_user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final ChatUser author;
  final int time;
  final String text;

  Message(this.author, this.time, this.text);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
