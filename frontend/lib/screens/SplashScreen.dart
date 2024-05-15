import 'package:chatapp/components/Effects.dart';
import 'package:chatapp/screens/WelcomeScreen.dart';
import 'package:chatapp/screens/userpage.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    gotomainpage(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: ShimmerImg(),
      ),
    );
  }
}

Future<void> gotomainpage(context) async {
  // await Future.delayed(Duration(seconds: 3));
  var login =await fetchUserData();
  print(login);
  if (login == 1) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Userpage()));
  } else {
    // return WelcomeScreen();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const WelcomeScreen()));
  }
}
