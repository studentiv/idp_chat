import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idp_chat/models/chat.dart';
import 'package:idp_chat/models/message.dart';

class ChatRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late final chatsCollection = fireStore.collection('chats');

  Stream<List<Message>> watchMessages(String chatId) {
    final chatDoc = chatsCollection.doc(chatId);

    return chatDoc.snapshots().map((querySnapshot) {
      final data = querySnapshot.data();
      if (data != null) {
        final messagesData = data['messages'] as List<dynamic>;
        return messagesData.map((e) => Message.fromJson(e)).toList();
      } else {
        throw Exception('Failed to watch messages');
      }
    });
  }

  Future<void> addChat(String chatId) async {
    final doc = chatsCollection.doc(chatId);
    final snapshot = await doc.get();
    if (!snapshot.exists) {
      await doc.set(Chat(messages: []).toJson());
    }
  }

  Future<void> addMessage(Message message, String chatId) async {
    final doc = chatsCollection.doc(chatId);
    final authorJson = message.author.toJson();
    final json = message.toJson();
    json['author'] = authorJson;

    await doc.update({
      'messages': FieldValue.arrayUnion([json])
    });
  }
}
