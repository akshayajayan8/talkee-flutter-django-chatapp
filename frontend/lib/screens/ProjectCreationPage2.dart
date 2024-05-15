
import 'package:chatapp/components/Effects.dart';
import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/models/ProjectModel.dart';
import 'package:chatapp/screens/ProjectCreationPage.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:flutter/material.dart';

class ProjectCreationPage2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String projectid;
  ProjectCreationPage2({super.key, required this.projectid});
  final TextEditingController textController = TextEditingController();
  final ValueNotifier<List<Requirements>> requirements = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Requirements",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (PROJECT == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  MySnackBar(text: "Add details", bgcolor: Colors.red));
            } else {
              var requirementList = requirements.value;
              createProjectRequirements(context, requirementList,PROJECT as ProjectModel,projectid);
              // print(PROJECT?.members);
            }
          },
          child: const Icon(Icons.navigate_next),
        ),
        body: SafeArea(
            child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: MyTextField(
                          icon: Icons.task,
                          hintTxt: "Enter Requirement and Add",
                          inputType: TextInputType.multiline,
                          controller: textController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter Requirement";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            if (!(_formKey.currentState!.validate())) {
                              return;
                            } else {
                              // if (textController.value == null) {
                              //   ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
                              //       text: "Enter requirements", bgcolor: Colors.red));
                              // } else {
                              var r = Requirements(
                                  description: textController.text,
                                  reqid: projectid);
                              requirements.value.add(r);
                              textController.clear();
                              requirements.notifyListeners();
                            }
                            // }
                          },
                          icon: Icon(
                            Icons.add_box_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Requirements:",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ValueListenableBuilder(
                    valueListenable: requirements,
                    builder: (context, requirement, child) {
                      if (requirement.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: requirement.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: const Icon(Icons.task),
                                title: Text(requirement[index].description,
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                              );
                            });
                      } else {
                        return Text(
                          "Add requirements of the project",
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      }
                    })
              ],
            ),
          ),
        )));
  }
}
