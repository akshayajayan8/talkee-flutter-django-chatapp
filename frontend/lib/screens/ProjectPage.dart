import 'package:chatapp/components/pagetransition/RouteTransitions.dart';
import 'package:chatapp/screens/ProjectCreationPage.dart';
import 'package:chatapp/screens/ProjectManagement.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    getProjects(phone: USERDETAILS['phone']);

    return Scaffold(
        appBar: AppBar(
          title: Text('Projects', style: Theme.of(context).textTheme.bodyMedium),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, RouteTranstions.transtion1(ProjectCreationPage()));
            },
            child: const Icon(Icons.add)),
        body: SafeArea(
            child: ValueListenableBuilder(
                valueListenable: PROJECTS,
                builder: (BuildContext context, projects, Widget? child) {
                  if (projects.isNotEmpty) {
                    //print(friends[1]);
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: projects.length,
                        itemBuilder: (BuildContext context, int index) {
                          var name = projects[index].pname;                      
                          return ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.group, size: 20)),
                              title: Text(
                                name,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   RouteTranstions.transtion1(
                                //       ProjectManagement(projectid: "1")),
                                // );
                                PROJECTID = (projects[index].pid).toString();//TAKING ID OF CLICKED PROJECT TO GET THE TASKS OF THE CORRESPOMDING PROJECT
                                Navigator.push(
                                  context,
                                  RouteTranstions.transtion1(
                                      const ProjectManagement()),
                                );
                              });
                        });
                  } else {
                    return Text('No Projects',
                        style: Theme.of(context).textTheme.bodyMedium);
                  }
                })));
  }
}
