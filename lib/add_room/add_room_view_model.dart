import 'package:chat/add_room/add_room_navigator.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/models/room.dart';
import 'package:flutter/material.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;
  addRoom(RoomModel room) async {
    navigator.showLoading();
    try {
      await DatabaseUtils.addRoomtoFirestore(room);
      navigator.hideLoading();
      navigator.showMessage('Room Added Successfully', true);
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString(), false);
    }
  }
}
