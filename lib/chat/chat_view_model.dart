import 'package:chat/chat/chat_navigator.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/room.dart';
import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  late ChatNavigator navigator;
  late RoomModel roomModel;
  late UserModel userModel;
  
  late Stream<QuerySnapshot<MessageModel>> streamMessage;
  void sendMessage(String content) {
    MessageModel cuurentMessage = MessageModel(
        roomid: roomModel.id,
        content: content,
        senderid: userModel.id,
        sendername: userModel.userName,
        date: DateTime.now().millisecondsSinceEpoch);

    try {
      DatabaseUtils.sendMessage(cuurentMessage);
      navigator.clearcontent();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void listenToAllMessage() {
  streamMessage=  DatabaseUtils.getAllMessage(roomModel.id);
  }
}
