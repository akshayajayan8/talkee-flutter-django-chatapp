
import 'package:chatapp/components/AppButton.dart';
import 'package:chatapp/components/MyTextField.dart';
import 'package:chatapp/components/images.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      My_Images.logo,
                      height: 250,
                      width: 250,
                    ),
                    Text("Talkee",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Please confirm your country code and enter your phone number',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      icon: Icons.mobile_friendly,
                      hintTxt: 'MOBILE NUMBER',
                      inputType: TextInputType.number,
                      controller: phone,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          {return "Enter Phone number";}
                        else if (value.length != 10)
                         { return "Enter a valid phone number";}
                        else
                          {return null;}
                      },
                    ),


                    const SizedBox(height: 10),
                    AppButton(
                        onTap: () {
                          if (!(_formKey.currentState!.validate())) {
                            return;
                          }
                          sendOtp(context,phone.text);
                          
                        },
                        text: "SEND OTP"),
                    //sized box

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
