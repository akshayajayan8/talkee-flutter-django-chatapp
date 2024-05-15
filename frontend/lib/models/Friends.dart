import 'package:chatapp/models/MessageModel.dart';

class FriendsModel {
  final String phone, fname, lname, email, date_joined;
  List<MessageModel> Messages=[];

  FriendsModel({required this.phone, required this.fname, required this.lname, required this.email, required this.date_joined});

  static  FriendsModel fromJson(Map friendsJson)=>(  FriendsModel(phone: friendsJson['phone'],
          fname: friendsJson['fname'],
          lname: friendsJson['lname'],
          email: friendsJson['email'],
          date_joined: friendsJson['date_joined']));
}
