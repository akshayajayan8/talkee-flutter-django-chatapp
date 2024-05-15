import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';



class ProjectManagement extends StatefulWidget {
  const ProjectManagement({
    super.key,
  });

  @override
  State<ProjectManagement> createState() => _ProjectManagement();
}

class _ProjectManagement extends State<ProjectManagement> {
  @override
  void initState() {
    getMyTasks(USERDETAILS['phone'], PROJECTID);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentindex = 0;
  final List<Widget> pages = [
    TasksPage(),
    const CompletedTaskPage(),
    const  ProfileDashboardPage(),
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
            icon: Icon(Icons.work),
            label: "Your Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_sharp),
            label: "Compeleted Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: "DashBoard",
          ),
        ],
        onTap: (value) => setState(() {
          // print(MYTASKS[0].status);
          // print(MYTASKS[0].deadline);
          // print(MYTASKS[0].assignedTo);
          // print(MYTASKS[0].taskid);
          // print(MYTASKS[0].projectid);
          // print(MYTASKS[0].taskname);
          // print(MYTASKS[0].reqid);

          currentindex = value;
          print(currentindex);
        }),
      ),
    );
  }
}




class TasksPage extends StatefulWidget {
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text("Your Tasks", style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
          valueListenable:MYTASKS ,
          builder: (context,mytasks,child) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: mytasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: Icon(Icons.task),
                      title: Text(
                        mytasks[index].taskname,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Text("deadline:${mytasks[index].deadline},",
                          style: Theme.of(context).textTheme.bodySmall),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (mytasks[index].status != "completed") {
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Are you sure want to Update the task?",
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        updateTask(context,
                                                            mytasks[index].taskid);
                                                        setState(() {
                                                          mytasks[index].status =
                                                              "completed";
                                                          updateTask(
                                                              context,
                                                              mytasks[index]
                                                                  .taskid);
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text("Yes")),
                                                  const SizedBox(width: 20),
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text("No")),
                                                ],
                                              )
                                            ],
                                          )));
                                });
                          }
                        },
                        child: (mytasks[index].status == "completed")
                            ? Container(
                                child: Text("completed",
                                    style: Theme.of(context).textTheme.bodySmall),
                                color: Colors.green)
                            : Container(
                                child: Text("complete",
                                    style: Theme.of(context).textTheme.bodySmall),
                                color: Colors.blue,
                              ),
                      ));
                });
          }
        ),
      ],
    );
  }
}

class CompletedTaskPage extends StatefulWidget {
  const CompletedTaskPage({
    super.key,
  });

  @override
  State<CompletedTaskPage> createState() => _CompletedTaskPageState();
}

class _CompletedTaskPageState extends State<CompletedTaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    getProjectTasks(PROJECTID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Text("Completed Tasks", style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(
          height: 20,
        ),
        ValueListenableBuilder(
          valueListenable: PROJECTTASKS,
          builder: (context,projectTasks,child) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: projectTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      leading: Icon(Icons.task),
                      title: Text(
                        projectTasks[index].taskname,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Text(
                          "deadline:${projectTasks[index].deadline} updated on:${projectTasks[index].updatedDate}",
                          style: Theme.of(context).textTheme.bodySmall),
                      trailing: Container(
                          child: Text("completed",
                              style: Theme.of(context).textTheme.bodySmall),
                          color: Colors.green));
                });
          }
        ),
      ],
    );
  }
}

class ProfileDashboardPage extends StatefulWidget {
  const ProfileDashboardPage({
    super.key,
  });

  @override
  State<ProfileDashboardPage> createState() => _ProfileDashboardPageState();
}

class _ProfileDashboardPageState extends State<ProfileDashboardPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCount(PROJECTID);
    print(COUNT);
  }

  @override
  Widget build(BuildContext context) {
    print(COUNT.value);
   
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Project Status", style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox(height: 20,),
          ValueListenableBuilder(
            valueListenable: COUNT,
            builder: (context,count,child) {
              double percentage = PROJECTTASKS.value.length / count;
              return Center(
                  child: CircularPercentIndicator(
                radius: 200,
                lineWidth: 10,
                percent: percentage,
                progressColor: Colors.deepPurple,
                backgroundColor: Colors.deepPurple.shade100,
                center: Text(
                  "${(percentage*100).round()}%",
                  style: TextStyle(fontSize: 50, ),
                ),
              ));
            }
          )
        ],
      ),
    );
  }
}
