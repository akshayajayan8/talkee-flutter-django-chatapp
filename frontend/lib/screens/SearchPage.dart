import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            MyTextField(
                icon: Icons.search,
                hintTxt: "Search for users",
                inputType: TextInputType.number,
                controller: searchcontroller),
            IconButton(
                onPressed: () {
                  searchUser(context, searchcontroller.text);
                },
                icon: const Icon(Icons.search)),
            ValueListenableBuilder(
                valueListenable: USERS,
                builder: (BuildContext context, users, Widget? child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        var fname = users[index][index]['fname'];
                        var lname = users[index][index]['lname'];
                        var phone = users[index][index]['phone'];

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
                          trailing: ElevatedButton(
                              onPressed: () {
                                sendFriendReq(
                                    context: context,
                                    to_user_phone: phone,
                                    userphone: USERPHONE.toString());
                                USERS.value = [];
                              },
                              child: const Text("send friend request")),
                        );
                      });
                })
          ],
        ));
  }
}
