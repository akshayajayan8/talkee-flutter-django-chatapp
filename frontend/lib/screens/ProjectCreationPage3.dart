import 'package:chatapp/components/AppButton.dart';
import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/models/ProjectModel.dart';
import 'package:chatapp/screens/ProjectCreationPage.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:flutter/material.dart';

class ProjectCreationPage3 extends StatefulWidget {
  final List<Requirements>? reqlist;
  final List<Members>? memberlist;
  final String projectid;

  const ProjectCreationPage3(
      {super.key,
      required this.reqlist,
      required this.memberlist,
      required this.projectid});

  @override
  State<ProjectCreationPage3> createState() => _ProjectCreationPage3State();
}

class _ProjectCreationPage3State extends State<ProjectCreationPage3> {
  String? memberidController, reqidController;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController dateController = TextEditingController();

  final TextEditingController textController = TextEditingController();

  final ValueNotifier<List<Tasks>> tasks = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Tasks",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                MyTextField(
                  icon: Icons.task,
                  hintTxt: "Enter Task and Add",
                  inputType: TextInputType.multiline,
                  controller: textController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter tasks";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  icon: Icons.calendar_month,
                  hintTxt: "deadline",
                  inputType: TextInputType.datetime,
                  controller: dateController,
                  readOnly: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter date";
                    } else {
                      return null;
                    }
                  },
                  onTap: () {
                    selectdate();
                  },
                ),
                DropdownButtonFormField(
                  items: widget.reqlist!
                      .map((e) => DropdownMenuItem(
                          value: e.reqid, child: Text(e.description)))
                      .toList(),
                  onChanged: (value) {
                    reqidController = value as String;
                    print(value);
                  },
                  hint: const Text("Select Requirement"),
                  dropdownColor: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  items: widget.memberlist!
                      .map((e) => DropdownMenuItem(
                          value: e.phone, child: Text("${e.fname} ${e.lname}")))
                      .toList(),
                  onChanged: (value) {
                    memberidController = value as String;
                    print(value);
                    print(memberidController);
                  },
                  hint: const Text("Assign to Member"),
                  dropdownColor: Colors.black,
                ),
                IconButton(
                    onPressed: () {
                      if (!(_formKey.currentState!.validate())) {
                        return;
                      } else {
                        var t = Tasks(
                            projectid: widget.projectid,
                            reqid: reqidController.toString(),
                            taskname: textController.text,
                            deadline: dateController.text,
                            assignedTo: memberidController.toString());
                        tasks.value.add(t);
                        textController.clear();
                        dateController.clear();
                        tasks.notifyListeners();
                      }
                    },
                    icon: Icon(
                      Icons.add_box_rounded,
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                ValueListenableBuilder(
                    valueListenable: tasks,
                    builder: (context, task, child) {
                      if (task.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: task.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.task),
                                title: Text(task[index].taskname,
                                    style: Theme.of(context).textTheme.bodySmall),
                                subtitle: Text(task[index].assignedTo.toString(),
                                    style: Theme.of(context).textTheme.bodySmall),
                                trailing: Text(task[index].deadline,
                                    style: Theme.of(context).textTheme.bodySmall),
                              );
                            });
                      } else {
                        return Text(
                          "Add requirements of the project",
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                    }),
                const SizedBox(height: 20),
                AppButton(
                    onTap: () {
                      createProjectTasks(context, tasks.value);
          
                      print(tasks.value);
                    },
                    text: "Create Project")
              ],
            ),
          ),
        ));
  }

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
