import 'package:chat/chat/chat_navigator.dart';
import 'package:chat/chat/chat_view_model.dart';
import 'package:chat/chat/message_iteam.dart';
import 'package:chat/models/message.dart';
import 'package:chat/models/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatViewModel viewModel = ChatViewModel();
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    viewModel.navigator = this;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as RoomModel;
    var provider = Provider.of<UserProvider>(context);

    viewModel.userModel = provider.currentUser!;
    viewModel.roomModel = args;
    viewModel.listenToAllMessage();
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
              title: Text(args.title),
              centerTitle: true,
            ),
            body: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.05,
                    horizontal: 10),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
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
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<MessageModel>>(
                        stream: viewModel.streamMessage,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            List<MessageModel> messageList = snapshot.data!.docs
                                .map(
                                  (doc) => doc.data(),
                                )
                                .toList();
                            return ListView.builder(
                              reverse: true,// change
                              itemCount: messageList.length,
                              itemBuilder: (context, index) => MessageIteam(
                                messageModel: messageList[index],
                                user: viewModel.userModel,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              hintText: 'Type Message',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () {
                              viewModel.sendMessage(messageController.text);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Send',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ))
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  void clearcontent() {
    messageController.clear();
    setState(() {});
    // TODO: implement clearcontent
  }
}
