import 'package:chatapp/main.dart';
import 'package:chatapp/models/Friends.dart';
import 'package:chatapp/models/ProjectModel.dart';
import 'package:flutter/material.dart';

//GLOBAL VARIABLES

ValueNotifier<List> USERS = ValueNotifier([]);
List FRIEND_REQ = [];
// ValueNotifier<List> FRIENDS = ValueNotifier([]);
ValueNotifier<List<FriendsModel>> FRIENDS = ValueNotifier([]);
ValueNotifier<List<ProjectModel>> PROJECTS = ValueNotifier([]);
ValueNotifier<List<Tasks>> MYTASKS = ValueNotifier([]);
ValueNotifier<List<Tasks>> PROJECTTASKS = ValueNotifier([]);
ValueNotifier<int> COUNT = ValueNotifier(0);

Map USERDETAILS = {};

String? USERPHONE;

const List langs = [
  {"name": "English", "code": "en"},
  {"name": "Hindi", "code": "hi"},
  {"name": "Malayalam", "code": "ml"},
  {"name": "Spanish", "code": "es"},
  {"name": "Japanese", "code": "ja"},
  {"name": "French", "code": "fr"},
  {"name": "German", "code": "de"}
];

void clearAllData() {
  FRIEND_REQ = [];
  FRIENDS.value = [];
  USERDETAILS = {};
  userdata.clear();
}

String? PROJECTID;
