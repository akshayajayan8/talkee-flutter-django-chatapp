import 'dart:convert';
import 'package:chatapp/components/Effects.dart';
import 'package:chatapp/components/pagetransition/RouteTransitions.dart';
import 'package:chatapp/main.dart';
import 'package:chatapp/models/Friends.dart';
import 'package:chatapp/models/ProjectModel.dart';
import 'package:chatapp/screens/ProjectCreationPage2.dart';
import 'package:chatapp/screens/ProjectCreationPage3.dart';
import 'package:chatapp/screens/RegisterPage.dart';
import 'package:chatapp/screens/userpage.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:chatapp/server/serverurls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/OtpVerify.dart';

//Shared preference functions

//FUNCTIONS

// TO SEND OTP TO PROVIDED NUMBER

Future<void> sendOtp(BuildContext context, String phone) async {
  var req = jsonEncode({'phone': phone});
  var response = await http.post(sendOtppath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    Navigator.push(
        context, RouteTranstions.transtion1(OtpVerify(phone: phone)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: "SOMETHING ERROR OCCURED.. TRY AGAIN",
    ));
  }
}

//FUNCTION TO RESEND OTP TO PROVIDED NUMBER

Future<void> resendOtp(BuildContext context, String phone) async {
  var req = jsonEncode({'phone': phone});
  var response = await http.post(sendOtppath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      text: "A new Otp has just sent to your mobile number",
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: "SOMETHING ERROR OCCURED.. TRY AGAIN",
    ));
  }
}

//FUNCTION TO AUTHORISE USER WITH PROVIDED OTP

Future<void> userAuth(BuildContext context, phone, String otp) async {
  var req = jsonEncode({'phone': phone, 'otp': otp});
  var response = await http.post(userAuthpath,
      headers: {"Content-Type": "application/json"}, body: req);
  //status code 202 for new user
  if (response.statusCode == 202) {
    Navigator.pushReplacement(
        context,
        RouteTranstions.transtion1(RegisterPage(
          phone: phone,
        )));
  }
  //status code 201 for already registered user
  else if (response.statusCode == 201) {
    //add value to global variable confirming login
    saveUserData(response.body);
    fetchUserData();
    Navigator.pushAndRemoveUntil(
        context, RouteTranstions.transtion1(Userpage()), (route) => false);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: "Otp is incorrect Try Again",
    ));
  }
}

Future<void> registerUser(BuildContext context, phone, String fname,
    String lname, String email) async {
  print('entered');
  var req = jsonEncode({
    'phone': phone,
    'fname': fname,
    "lname": lname,
    "email": email,
  });
  var response = await http.post(regUserpath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    saveUserData(response.body);
    fetchUserData();
    Navigator.pushAndRemoveUntil(
        context, RouteTranstions.transtion1(Userpage()), (route) => false);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      text: "User details added successfully",
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: "Error occured on adding user details Try Again",
    ));
  }
}

//SEARCH FOR USER

Future<void> searchUser(BuildContext context, String phone) async {
  var req = jsonEncode({'phone': phone});
  var response = await http.post(searchUserpath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
    USERS.value = [data]; //USER IS A VALUE NOTIFIER
    print(USERS.value);
    USERS.notifyListeners();
  } else {
    USERS.value = [];
    print(USERS.value);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: response.body,
    ));
    print(response.body);
  }
}

//TO SEND FRIEND REQUEST

Future<void> sendFriendReq(
    {required BuildContext context,
    required String userphone,
    required String to_user_phone}) async {
  var req = jsonEncode(
      {'from_user_phone': userphone, 'to_user_phone': to_user_phone});
  var response = await http.post(sendFriendReqpath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Theme.of(context).colorScheme.primary,
      text: response.body,
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: response.body,
    ));
    print(response.body);
  }
}

//Functions to get all friend requests

void getAllReq({required String to_user}) async {
  var req = jsonEncode({'to_user': to_user});
  var response = await http.post(getAllReqpath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
    var friendlist = [data];
    FRIEND_REQ = friendlist[0];
  } else {
    FRIEND_REQ = [];
  }
}

//Function to get all friends

void getFriends({String? phone}) async {
  FRIENDS.value = [];
  var req = jsonEncode({'phone': phone});
  var response = await http.post(getFriendspath,
      headers: {"Content-Type": "application/json"}, body: req);

  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
    var friendlist = [data];
    List friends = friendlist[0];
    for (int i = 0; i < friends.length; ++i) {
      var friend = FriendsModel.fromJson(friends[i]);
      FRIENDS.value.add(friend);
    }
    FRIENDS.notifyListeners();
  } else {
    FRIENDS.value = [];
  }
}

void saveUserData(String response) {
  var data = jsonDecode(response);
  userdata.setString('phone', data[0]['phone']);
  userdata.setString('fname', data[0]['fname']);
  userdata.setString("lname", data[0]['lname']);
  userdata.setString("email", data[0]['email']);
  userdata.setString('date_joined', data[0]["date_joined"]);
}

int fetchUserData() {
  print("started");
  var phone = userdata.getString("phone");
  var fname = userdata.getString("fname");
  var lname = userdata.getString("lname");
  var email = userdata.getString("email");
  var date_joined = userdata.getString("date_joined");
  print("end");
  print(phone);
  if (phone == null) {
    return -1;
  } else {
    USERDETAILS = {
      'phone': phone,
      'fname': fname,
      "lname": lname,
      "email": email,
      'date_joined': date_joined
    };
    return 1;
  }
}

//accept friend request

Future<void> acceptFriendReq(
    {required BuildContext context,
    required String userphone,
    required String to_user_phone,
    required String acceptorreject}) async {
  var req = jsonEncode({
    'from_user_phone': userphone,
    'to_user_phone': to_user_phone,
    'acceptorreject': acceptorreject
  });
  var response = await http.post(acceptFriendReqpath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    print(response.body);
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Theme.of(context).colorScheme.primary,
      text: response.body,
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(MySnackBar(
      bgcolor: Colors.red,
      text: response.body,
    ));
  }
}

//SEND PROJECT DETAILS

createProject(BuildContext context, ProjectModel value) async {
  var req = ProjectModel.toJson(value);
  List<Members> members = value.members;
  List memberids = [];
  for (int i = 0; i < members.length; i++) {
    memberids.add(members[i].phone);
  }
  req['members'] = memberids;
  var response = await http.post(createProjectPath,
      headers: {"Content-Type": "application/json"}, body: jsonEncode(req));
  String pid = jsonDecode(response.body).toString();
  if (response.statusCode == 201) {
    print("success");
    print(pid);
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: "Successfully added details"));
    Navigator.of(context)
        .push(RouteTranstions.transtion1(ProjectCreationPage2(projectid: pid)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(text: "Something error occured", bgcolor: Colors.red));
  }
}

//CREATE PROJECT STEP 1

createProjectRequirements(BuildContext context, List<Requirements> value,
    ProjectModel project, String proid) async {
  List<Members> memberList = project.members;
  List requirementList = [];
  for (int i = 0; i < value.length; i++) {
    var requirement = Requirements.toJson(value[i]);
    requirementList.add(requirement);
  }
  var response = await http.post(createProjectRequirementsPath,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"requirements": requirementList, "proid": proid}));

  if (response.statusCode == 201) {
    List<Requirements> reqList = [];
    var reqListjson = jsonDecode(response.body);
    print(reqListjson);
    for (int i = 0; i < reqListjson.length; i++) {
      print(reqListjson[i]['rid']);
      var reqid = reqListjson[i]['rid'].toString();
      var description = reqListjson[i]['description'].toString();
      print(reqid + description);
      var r = Requirements(reqid: reqid, description: description);
      reqList.add(r);
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: "Successfully added details"));
    Navigator.of(context).push(RouteTranstions.transtion1(ProjectCreationPage3(
        reqlist: reqList, memberlist: memberList, projectid: proid)));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(text: "Something error occured", bgcolor: Colors.red));
  }
}

//CREATE PROJECT STEP 2

createProjectTasks(BuildContext context, List<Tasks> value) async {
  List taskList = [];
  for (int i = 0; i < value.length; i++) {
    var task = Tasks.toJson(value[i]);
    taskList.add(task);
  }
  var response = await http.post(createProjectTasksPath,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(taskList));

  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: "Successfully added details"));
    Navigator.pushAndRemoveUntil(
        context, RouteTranstions.transtion1(Userpage()), (route) => false);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(text: "Something error occured", bgcolor: Colors.red));
  }
}

//GET PROJECT DETAILS
void getProjects({String? phone}) async {
  PROJECTS.value = [];
  var req = jsonEncode({'phone': phone});
  var response = await http.post(getProjectsspath,
      headers: {"Content-Type": "application/json"}, body: req);

  if (response.statusCode == 201) {
    var data = jsonDecode(response.body);
    var projectlist = [data];
    List projects = projectlist[0];
    for (int i = 0; i < projects.length; ++i) {
      var project = ProjectModel(
          pid: projects[i]['pid'].toString(),
          pname: projects[i]['pname'],
          info: projects[i]['info'],
          deadline: projects[i]['deadline'],
          admin: projects[i]['admin']);
      PROJECTS.value.add(project);
    }

    // print(PROJECTS.value);
    PROJECTS.notifyListeners();
  } else {
    PROJECTS.value = [];
    // print(PROJECTS.value);
    // print(response.body);
  }
}

//UPDATE TASK

updateTask(BuildContext context, String? taskId) async {
  var req = jsonEncode({'taskid': taskId});
  var response = await http.post(updatetaskPath,
      headers: {"Content-Type": "application/json"}, body: req);
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackBar(text: "Task Updated"));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackBar(text: "Something error occured", bgcolor: Colors.red));
  }
}

//GET TASKS

void getMyTasks(String? user, String? projectid) async {
  MYTASKS.value = [];
  var req = jsonEncode({'phone': user, 'projectid': projectid});
  var response = await http.post(getMytaskPath,
      headers: {"Content-Type": "application/json"}, body: req);
  var tasks = jsonDecode(response.body);
  print(tasks);

  for (int i = 0; i < tasks.length; i++) {
    print("loop started");
    var r = Tasks.fromjson(tasks[i]);
    MYTASKS.value.add(r);
  }
}

void getProjectTasks(String? projectid) async {
  PROJECTTASKS.value = [];
  var req = jsonEncode({'projectid': projectid});
  var response = await http.post(getProjectTasksPath,
      headers: {"Content-Type": "application/json"}, body: req);
  var tasks = jsonDecode(response.body);

  for (int i = 0; i < tasks.length; i++) {
    var r = Tasks.fromjson(tasks[i]);
    PROJECTTASKS.value.add(r);
  }
  for (int i = 0; i < PROJECTTASKS.value.length; i++) {
    print(PROJECTTASKS.value[i].taskname);
  }
  PROJECTTASKS.notifyListeners();
}

//get COUNT

void getCount(String? projectid) async {
  var req = jsonEncode({'projectid': projectid});
  var response = await http.post(getCountPath,
      headers: {"Content-Type": "application/json"}, body: req);
  var data = json.decode(response.body);
  // print(data);
  COUNT.value = data;
  // print(COUNT);
}
