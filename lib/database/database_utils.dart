import 'package:chat/models/message.dart';
import 'package:chat/models/room.dart';
import 'package:chat/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.ToFirestore(),
        );
  }

  static Future<void> registerUser(UserModel user) async {
    getUserCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> getUser(String userid) async {
    DocumentSnapshot<UserModel> documentSnapshot =
        await getUserCollection().doc(userid).get();
    return documentSnapshot.data();
  }

  static CollectionReference<RoomModel> getroomCollection() {
    return FirebaseFirestore.instance
        .collection('rooms')
        .withConverter<RoomModel>(
          fromFirestore: (snapshot, options) =>
              RoomModel.fromjson(snapshot.data()!),
          toFirestore: (room, options) => room.ToFirestore(),
        );
  }

  static Future<void> addRoomtoFirestore(RoomModel room) async {
    DocumentReference<RoomModel> documentReference = getroomCollection().doc();
    room.id = documentReference.id;
    return documentReference.set(room);
  }

  static Stream<QuerySnapshot<RoomModel>> getAllRooms() {
    return getroomCollection().snapshots();
  }

  static CollectionReference<MessageModel> getMessageCollection(String roomid) {
    return getroomCollection()
        .doc(roomid)
        .collection('messages')
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (message, options) => message.ToFirestore(),
        );
  }

  static Future<void> sendMessage(MessageModel message) async {
    DocumentReference<MessageModel> documentReference =
        getMessageCollection(message.roomid).doc();
    message.id = documentReference.id;
    return documentReference.set(message);
  }

  static Stream<QuerySnapshot<MessageModel>> getAllMessage(String roomid) {
    return getMessageCollection(roomid)
        .orderBy('date', descending: true)
        .snapshots(); //change
  }
}
