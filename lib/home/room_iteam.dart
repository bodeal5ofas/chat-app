import 'package:chat/chat/chat_screen.dart';
import 'package:chat/models/room.dart';
import 'package:flutter/material.dart';

class RoomIteam extends StatelessWidget {
  const RoomIteam({super.key, required this.roomModel});
  final RoomModel roomModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.id, arguments: roomModel);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Image.asset(
                'assets/${roomModel.categoryid}.png',
                height: MediaQuery.of(context).size.height * 0.15,
                fit: BoxFit.fill,
              ),
              Text(
                roomModel.title,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
