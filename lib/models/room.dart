import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String id;
  String title;
  String description;
  String categoryid;
  RoomModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.categoryid});
  factory RoomModel.fromjson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      categoryid: json['categoryid'],
    );
  }
  Map<String, dynamic> ToFirestore() {
    return {
      'id': id,
      'title': title,
      "description": description,
      'categoryid': categoryid,
    };
  }
}
