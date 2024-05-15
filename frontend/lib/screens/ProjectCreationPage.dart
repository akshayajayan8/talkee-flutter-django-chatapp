import 'package:chatapp/components/Effects.dart';
import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/models/ProjectModel.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';

ProjectModel? PROJECT;

class ProjectCreationPage extends StatefulWidget {
  @override
  State<ProjectCreationPage> createState() => _ProjectCreationPageState();
}

class _ProjectCreationPageState extends State<ProjectCreationPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController searchController = TextEditingController();

  final TextEditingController infoController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final ValueNotifier<List<Members>> members = ValueNotifier([]);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //Side next Button
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (PROJECT == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    MySnackBar(text: "Add details", bgcolor: Colors.red));
              } else {
               
                PROJECT?.members = members.value;
                print(PROJECT?.members);
                createProject(context, PROJECT as ProjectModel);
              }
              //SAVING MEMBERS DATA
            },
            child: const Icon(Icons.navigate_next)),
        //APPBAR WITH CREATE PROJECT TITLE

        appBar: AppBar(
            title: Text(
          "Create Project",
          style: Theme.of(context).textTheme.bodyMedium,
        )),
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: ListView(children: [
                //FORM FIELDS
                MyTextField(
                  icon: Icons.group_work,
                  hintTxt: "Project Name",
                  inputType: TextInputType.name,
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter project name";
                    } else {
                      return null;
                    }
                  },
                ),
                MyTextField(
                  icon: Icons.info,
                  hintTxt: "Your Project Info",
                  inputType: TextInputType.multiline,
                  controller: infoController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter project info";
                    } else {
                      return null;
                    }
                  },
                ),
                MyTextField(
                  icon: Icons.calendar_month,
                  hintTxt: "deadline",
                  inputType: TextInputType.datetime,
                  controller: dateController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter deadline";
                    } else {
                      return null;
                    }
                  },
                  readOnly: true,
                  onTap: () {
                    selectdate();
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (!(_formKey.currentState!.validate())) {
                        return;
                      } else {
                        //SAVING DATA
                        PROJECT = ProjectModel(
                            pname: nameController.text,
                            admin: "9207826073", //USERDETAILS['phone'],
                            deadline: dateController.text,
                            info: infoController.text);
                        //USER SEARCH BOTTOM BAR
                        userSearchBottomSheet();
                      }
                    },
                    child: const Text("Add Members")),
                const SizedBox(height: 20),
                Text("MEMBERS:", style: Theme.of(context).textTheme.bodySmall),
                ValueListenableBuilder(
                    valueListenable: members,
                    builder: (context, member, child) {
                      if (member.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: member.length,
                            itemBuilder: (BuildContext context, int index) {
                              var fname = member[index].fname;
                              var lname = member[index].lname;
                              var phone = member[index].phone;

                              return ListTile(
                                  leading: const CircleAvatar(
                                      child: Icon(Icons.person, size: 20)),
                                  title: Text(
                                    "$fname $lname",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  subtitle: Text(
                                    phone,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  trailing: const Icon(
                                    Icons.verified,
                                    color: Colors.green,
                                  ));
                            });
                      } else {
                        return Text(
                          "Add some members",
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                    })
              ])),
        ));
  }

  //FUNCTION TO SHOW USER SEARCHBOTTOM SHEET
  userSearchBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(children: [
            MyTextField(
                icon: Icons.search,
                hintTxt: "Search for users",
                inputType: TextInputType.number,
                controller: searchController),
            IconButton(
                onPressed: () {
                  searchUser(context, searchController.text);
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
                        var email = users[index][index]['email'];
                        var date_joined = users[index][index]['date_joined'];

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
                                var f = Members(
                                    phone: phone,
                                    fname: fname,
                                    lname: lname,
                                    email: email,
                                    date_joined: date_joined);
                                members.value.add(f);
                                members.notifyListeners();
                                searchController.clear();
                                print(members.value);

                                USERS.value = [];
                                Navigator.of(context).pop();
                              },
                              child: const Text("Add")),
                        );
                      });
                })
          ]);
        });
  }

  //DATE SELECT FUNCTION
  selectdate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        currentDate: DateTime.now());
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
