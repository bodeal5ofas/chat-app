import 'package:chat/models/message.dart';
import 'package:chat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageIteam extends StatefulWidget {
  const MessageIteam(
      {super.key, required this.messageModel, required this.user});
  final MessageModel messageModel;
  final UserModel user;

  @override
  State<MessageIteam> createState() => _MessageIteamState();
}

class _MessageIteamState extends State<MessageIteam> {
  bool isYourMessage = false;

  @override
  void initState() {
    if (widget.messageModel.senderid == widget.user.id) {
      isYourMessage = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isYourMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: isYourMessage
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
              color: isYourMessage ? Colors.blue : Colors.grey,
            ),
            padding: const EdgeInsets.all(15),
            child: Text(
              widget.messageModel.content,
              style: const TextStyle(color: Colors.black, fontSize: 23),
            ),
          ),
          Text(DateFormat('hh:mm a')
              .format(
                  DateTime.fromMillisecondsSinceEpoch(widget.messageModel.date))
              .toString()),
        ],
      ),
    );
  }
}
