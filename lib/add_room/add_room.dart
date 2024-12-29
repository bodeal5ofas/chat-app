import 'package:chat/add_room/add_room_navigator.dart';
import 'package:chat/add_room/add_room_view_model.dart';
import 'package:chat/helper.dart';
import 'package:chat/models/category.dart';
import 'package:chat/models/room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({super.key});
  static String id = 'AddRoom';
  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  GlobalKey<FormState> formKey = GlobalKey();
  String roomTitle = '';
  String roomDescription = '';
  late CategoryModel selectedCategory;
  List<CategoryModel> categryList = CategoryModel.getCategries();
  @override
  void initState() {
    viewModel.navigator = this;
    selectedCategory = categryList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: Colors.blue,
              title: Text("Add room"),
              centerTitle: true,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1,
                  horizontal: 20),
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            'Create New Room',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Image.asset('assets/room.png'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Room Name',
                            ),
                            onChanged: (value) {
                              roomTitle = value;
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          DropdownButton<CategoryModel>(
                            value: selectedCategory,
                            items: categryList
                                .map(
                                  (category) => DropdownMenuItem<CategoryModel>(
                                      value: category,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(category.title),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(category.image),
                                        ],
                                      )),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Enter Room Description',
                            ),
                            onChanged: (value) {
                              roomDescription = value;
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'this field is required';
                              }
                              return null;
                            },
                            maxLines: 4,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RoomModel room = RoomModel(
                                    id: '',
                                    title: roomTitle,
                                    description: roomDescription,
                                    categoryid: selectedCategory.id);
                                viewModel.addRoom(room);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'create',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 23),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void hideLoading() {
    utilsDialog.hideLoading(context);
  }

  @override
  void showLoading() {
    utilsDialog.showLoading(context);
    // TODO: implement showLoading
  }

  @override
  void showMessage(String message, bool isRoom) {
    utilsDialog.showMessage(context: context, message: message, isRoom: isRoom);
    // TODO: implement showMessage
  }
}
