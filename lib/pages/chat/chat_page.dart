import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp_chat/models/message.dart';
import 'package:idp_chat/pages/chat/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage();

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.read<ChatCubit>().state.interlocutor.userName),
          ),
          body: BlocBuilder<ChatCubit, ChatState>(
              buildWhen: (p, n) => p.messages.length != n.messages.length,
              builder: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                });
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: state.messages
                            .map(
                              (e) =>
                                  _MessageItem(state.user.id == e.author.id, e),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.blueAccent,
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: TextField(
                                focusNode: focusNode,
                                onSubmitted: (_) => sendMessage(),
                                textInputAction: TextInputAction.send,
                                controller: controller,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Message',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Material(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: Colors.deepPurpleAccent,
                            child: InkWell(
                              onTap: sendMessage,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(Icons.send, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      );

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      final text = controller.text;
      final time = DateTime.now().millisecondsSinceEpoch;
      focusNode.unfocus();
      controller.clear();
      context.read<ChatCubit>().addMessage(time, text);
    }
  }
}

class _MessageItem extends StatelessWidget {
  final Message message;
  final bool isUserMessage;
  late final date = DateTime.fromMillisecondsSinceEpoch(message.time);

  _MessageItem(this.isUserMessage, this.message);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: 250),
            decoration: BoxDecoration(
              color: isUserMessage
                  ? Colors.green.shade900
                  : Colors.blueAccent.shade700,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      message.text,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${date.hour}:${date.minute}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
