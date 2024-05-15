import 'package:animate_do/animate_do.dart';
import 'package:chatapp/components/AppButton.dart';
import 'package:chatapp/components/images.dart';
import 'package:chatapp/components/pagetransition/RouteTransitions.dart';
import 'package:chatapp/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width:double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            //sized box
            const SizedBox(height: 100),
            //logo
            BounceInDown(
              duration:const Duration(milliseconds: 1000),
              child: Image.asset(
                My_Images.logo,
                width: 250,
                height:250
            
              ),
             
            ),
            //appname
            FadeInUp(
                duration:const Duration(milliseconds: 500),
                delay:const Duration(milliseconds: 1000),
                child: Column(children: [
                  Text("Talkee",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  //
                  Text('A complete assistant for professionals',
                      style:Theme.of(context).textTheme.bodySmall),
            
                  //sizedbox
                  const SizedBox(height: 60),
                  //button
                  AppButton(
                      onTap: () {
                        Navigator.push(context,RouteTranstions.transtion1(LoginScreen()));
                      },
                      text: "Lets Get Started")
                ])),
                  ],
                ),
          ),
        ));
  }
}
