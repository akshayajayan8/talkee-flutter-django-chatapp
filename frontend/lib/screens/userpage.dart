import 'dart:convert';

import 'package:chatapp/components/pagetransition/RouteTransitions.dart';
import 'package:chatapp/screens/ChatDetails.dart';
import 'package:chatapp/screens/ProfilePage.dart';
import 'package:chatapp/screens/ProjectPage.dart';
import 'package:chatapp/screens/SearchPage.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:chatapp/server/serverurls.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';

var channel;

class Userpage extends StatefulWidget {
  Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  void initState() {
    getFriends(phone: USERDETAILS['phone']);
    connect();
    channel.stream.listen((data) {
      print(data);
      var mainmessage = jsonDecode(data);
      var message = mainmessage['message'];
      var sender = mainmessage['from_user'];
      var index = get_sender(sender);
      print(message);
      receiveMessage(message.toString(), index);
    });
    super.initState();
  }

  @override
  void dispose() {
    channel.sink.close();
    print("closed");
    super.dispose();
  }

  int currentindex = 0;
  final List<Widget> pages = [
    ChatPage(),
    ProjectPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey.shade600,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            label: "Projects",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (value) => setState(() {
          currentindex = value;
          print(currentindex);
        }),
      ),
    );
  }
}

//CHATLIST PAGE
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Friends', style: Theme.of(context).textTheme.bodyMedium),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, RouteTranstions.transtion1(SearchPage()));
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: FRIENDS,
                builder: (BuildContext context, friendslist, Widget? child) {
                  if (friendslist.isNotEmpty) {
                    //print(friends[1]);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: friendslist.length,
                        itemBuilder: (BuildContext context, int index) {
                          var fname = friendslist[index].fname;
                          var lname = friendslist[index].lname;
                          var phone = friendslist[index].phone;

                          return ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.person, size: 20)),
                              title: Text(
                                "$fname $lname",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              subtitle: Text(
                                "$phone",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteTranstions.transtion1(ChatDetailPage(
                                    name: "$fname $lname",
                                    user: phone,
                                    index: index,
                                  )),
                                );
                              });
                        });
                  } else {
                    return Text('No Friends',
                        style: Theme.of(context).textTheme.bodyMedium);
                  }
                })));
  }
}


//Connect to server

void connect() {
  channel =
      WebSocketChannel.connect(Uri.parse(SERVERWEBSOCKET + "${USERPHONE}/"));
  print(channel);
  print("connected");
}
