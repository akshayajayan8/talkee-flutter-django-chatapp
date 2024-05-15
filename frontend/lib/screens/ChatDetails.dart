import 'dart:convert';

import 'package:chatapp/models/MessageModel.dart';
import 'package:chatapp/screens/userpage.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

final translator = GoogleTranslator();

class ChatDetailPage extends StatefulWidget {
  final String name,user;
  final int index;

  const ChatDetailPage({super.key, required this.name,required this.user,required this.index});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final messageField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  maxRadius: 20,
                  child: Icon(
                    Icons.person,
                    size: 20,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: FRIENDS,
              builder: (BuildContext context, friends, Widget? child) {
                var messages = friends[widget.index].Messages;
                return ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  //physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: true,
                            isScrollControlled: true,
                            context: context,
                            builder: ((context) {
                              return SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: langs.length,
                                  itemBuilder: (context, index1) {
                                      return ListTile(
                                        leading: Text(langs[index1]['name'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                        onTap: () {
                                          translateTo(
                                              index: index,
                                              mainindex: widget.index,
                                              to_lang: langs[index1]['code']);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                  },
                                ),
                              );
                            }));
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade700
                                  : Theme.of(context).colorScheme.primary),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),

          //MESSAGE TYPING FIELD
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageField,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      sendMessage(messageField.text, widget.index);
                      channel.sink.add(jsonEncode({
                        "message": messageField.text,
                        "to_user": widget.user,
                        "from_user": USERPHONE,
                      }));

                      messageField.clear();
                    },
                    child: const Icon(
                      Icons.send,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

int get_sender(String sender) {
  var friends = FRIENDS.value;
  for (int i = 0; i < friends.length; ++i) {
    if (friends[i].phone == sender) {
      return i;
    }
  }
  return 0;
}

void receiveMessage(String message, int index) {
  var data = MessageModel(messageContent: message, messageType: "receiver");
  print("received message added to friend ${index}");
  print(data);
  print(data.messageContent);
  FRIENDS.value[index].Messages.add(data);
  print(FRIENDS.value[index].fname);
  // print(MESSAGES.value[0].messageContent);
  FRIENDS.notifyListeners();
}

void sendMessage(String message, int index) async {
  var data = MessageModel(messageContent: message, messageType: "sender");

  print("send message added to friend ${index}");
  FRIENDS.value[index].Messages.add(data);
  print(FRIENDS.value[index].fname);
  // MESSAGES.value.add(data);
  // print(MESSAGES.value[0].messageContent);
  // MESSAGES.notifyListeners();
  FRIENDS.notifyListeners();
}

//sendmessage function

void translateTo(
    {int index = 0, int mainindex = 0, String to_lang = "en"}) async {
  var translation = await translator.translate(
      FRIENDS.value[mainindex].Messages[index].messageContent,
      to: to_lang);
  print(translation);
  FRIENDS.value[mainindex].Messages[index].messageContent =
      translation.toString();
  FRIENDS.notifyListeners();
}
