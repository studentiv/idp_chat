import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final List<Message> messages;

  Chat({required this.messages});

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);

}
