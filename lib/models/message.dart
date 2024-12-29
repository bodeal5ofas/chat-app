import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String roomid;
  String content;
  String senderid;
  String sendername;
  int date;
  MessageModel(
      {this.id = '',
      required this.roomid,
      required this.content,
      required this.senderid,
      required this.sendername,
      required this.date});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      roomid: json['roomid'],
      content: json['content'],
      senderid: json['senderid'],
      sendername: json['sendername'],
      date: json['date'],
    );
  }
  Map<String, dynamic> ToFirestore() {
    return {
     'roomid': roomid,
     'content': content,
     'senderid': senderid,
      'sendername':sendername,
      'date':date,
    };
  }
}
