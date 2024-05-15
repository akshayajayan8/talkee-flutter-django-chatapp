import 'dart:io';

import 'package:chatapp/components/pagetransition/RouteTransitions.dart';
import 'package:chatapp/screens/LoginScreen.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  final String imagepath = "path";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
                  children: [
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    gallerypick();
                  },
                  child: image == null
                      ? CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          radius: 60,
                          child: Icon(
                            Icons.camera_alt_sharp,
                            size: 50,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          // backgroundImage: NetworkImage(widget.imagepath),
                          radius: 60,
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Name"),
                  subtitle: Text(
                      "${USERDETAILS['fname']} ${USERDETAILS['lname']}",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title:const Text("Phone"),
                  subtitle: Text("${USERDETAILS['phone']}",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text("E-mail"),
                  subtitle: Text("${USERDETAILS['email']} ",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text("Date "),
                  subtitle: Text("${USERDETAILS['date_joined']}",
                      style: Theme.of(context).textTheme.bodySmall),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(Icons.group),
                  title: Text("Friend Requests"),
                  onTap: () {
                    getAllReq(to_user: USERDETAILS['phone']);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          if (FRIEND_REQ.isNotEmpty) {
                            return ListView.builder(
                                itemCount: FRIEND_REQ.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                      height: 200,
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(children: [
                                              Text("Friend request from:",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              Text(
                                                  "${FRIEND_REQ[index]['fname']} ${FRIEND_REQ[index]['lname']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              Text(
                                                  "${FRIEND_REQ[index]['phone']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            ]),
                                            IconButton(
                                              onPressed: () {
                                                acceptFriendReq(
                                                    context: context,
                                                    userphone: FRIEND_REQ[index]
                                                        ['phone'],
                                                    to_user_phone:
                                                        USERDETAILS['phone'],
                                                    acceptorreject: "accept");
                                                Navigator.of(context).pop();
                                              },
                                              icon: Icon(Icons.check),
                                              color: Colors.green,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  acceptFriendReq(
                                                      context: context,
                                                      userphone:
                                                          FRIEND_REQ[index]
                                                              ['phone'],
                                                      to_user_phone:
                                                          USERDETAILS['phone'],
                                                      acceptorreject: "reject");
                                                  Navigator.of(context).pop();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                      ));
                                });
                          } else {
                            return Center(
                              child: Text("No pending friend requests",style:Theme.of(context).textTheme.bodySmall),
                            );
                          }
                        });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text(
                    "Log out",
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade800,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 200,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Are you sure want to logout?",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                clearAllData();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    RouteTranstions.transtion1(
                                                        LoginScreen()),
                                                    (route) => false);
                                              },
                                              child: const Text("Logout")),
                                          const SizedBox(width: 20),
                                          ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text("Cancel")),
                                        ],
                                      )
                                    ],
                                  )));
                        });
                  },
                ),

            
              ])),
        ),
      ),
    );
  }

  Future gallerypick() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(returnimage!.path);
    });
  }
}
