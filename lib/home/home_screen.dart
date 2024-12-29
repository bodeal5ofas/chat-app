import 'package:chat/add_room/add_room.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/home/home_navigator.dart';
import 'package:chat/home/home_view_model.dart';
import 'package:chat/home/room_iteam.dart';
import 'package:chat/login/login_screen.dart';
import 'package:chat/models/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator {
  HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    viewModel.userProvider = provider;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: double.infinity,
          ),
          Image.asset(
            'assets/background.png',
            height: double.infinity,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: logout,
                    icon: Icon(
                      Icons.logout,
                    ))
              ],
              backgroundColor: Colors.blue,
              title: Text("Home"),
              centerTitle: true,
            ),
            body: StreamBuilder<QuerySnapshot<RoomModel>>(
              stream: DatabaseUtils.getAllRooms(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  List<RoomModel> roomList = snapshot.data!.docs.map(
                    (e) {
                      return e.data();
                    },
                  ).toList();
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      itemCount: roomList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      itemBuilder: (context, index) =>
                          RoomIteam(roomModel: roomList[index]),
                    ),
                  );
                }
                return Text('');
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                Navigator.pushNamed(context, AddRoom.id);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void logout() {
    viewModel.logout();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }
}
