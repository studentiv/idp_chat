import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:idp_chat/models/chat_user.dart';

class ChatRepository {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  late final usersCollection = fireStore.collection('users');

  Future<void> addUser(ChatUser user) async {
    final newDoc = usersCollection.doc(user.id);

    await newDoc.set(user.toJson());
  }

  Future<ChatUser?> getUser(User user) async {
      final doc = usersCollection.doc(user.uid);
      ChatUser? chatUser;
      await doc.get().then((snapshot) async {
        if (snapshot.exists) {
          final data = snapshot.data();
          if (data != null) {
            chatUser = ChatUser.fromJson(data);
          } else {
            throw Exception('Failed to get user');
          }
        } else {
          chatUser = ChatUser(
            email: user.email,
            id: user.uid,
            userName: user.displayName ?? 'Unknown user',
          );
          await addUser(chatUser!);
        }
      }).catchError((error) => throw Exception(error));

      return chatUser;
  }
}
