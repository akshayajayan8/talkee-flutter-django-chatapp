
import 'package:chatapp/components/AppButton.dart';
import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class RegisterPage extends StatefulWidget {
  final String phone;
  RegisterPage({
    super.key,
    required this.phone,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? image;

  //controllers
  final TextEditingController fname = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController lname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Center(
        child: Container(
          width: 350,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  gallerypick();
                },
                child: image == null
                    ? CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        radius: 60,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 50,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 60,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Your Info",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(
                height: 20,
              ),
              Text(
                'Please add your details',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
              ),

              SizedBox(
                height: 20,
              ),
              MyTextField(
                icon: Icons.person,
                hintTxt: "First Name",
                inputType: TextInputType.name,
                controller: fname,
              ),
              MyTextField(
                icon: Icons.person,
                hintTxt: "Last Name",
                inputType: TextInputType.name,
                controller: lname,
              ),
              //name
              MyTextField(
                icon: Icons.mail,
                hintTxt: "E-Mail",
                inputType: TextInputType.emailAddress,
                controller: email,
              ),
              //email

              //address
              SizedBox(
                height: 30,
              ),
              AppButton(
                  onTap: () {
                    print('clicked');
                    registerUser(context, widget.phone, fname.text, lname.text,
                        email.text);
                  },
                  text: 'REGISTER'),
              // Text(
              //   'Already a User?',
              //   style: TextStyle(
              //       color: Theme.of(context).colorScheme.secondary,
              //       fontFamily: 'Poppinsthin',
              //       letterSpacing: 5,
              //       fontSize: 20),
              //   textAlign: TextAlign.center,
              // ),
              // GestureDetector(
              //     onTap: onTap,
              //     child: Text(
              //       'Log In',
              //       style: TextStyle(
              //           shadows: [
              //             Shadow(
              //               blurRadius: 5,
              //               color: Colors.blue,
              //             )
              //           ],
              //           color: Theme.of(context).colorScheme.primary,
              //           fontSize: 25),
              //     )),
            ],
          ),
        ),
      ),
    )));
  }

  Future gallerypick() async {
    final returnimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(returnimage!.path);
    });
  }
}

