import 'package:chatapp/components/images.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImg extends StatelessWidget {
  const ShimmerImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Shimmer.fromColors(
            child: Image.asset(My_Images.logo),
            baseColor: Colors.purple,
            highlightColor: Colors.pink),
      ),
    );
  }
}

// class MySnackBar extends StatelessWidget {
//   final bgcolor, text;
//   const MySnackBar({super.key, this.bgcolor, this.text});

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//         behavior: SnackBarBehavior.floating,
//         margin: EdgeInsets.all(10),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         content: Text(text, style: TextStyle(color: bgcolor, fontSize: 20)));
//   }
// }
SnackBar MySnackBar({Color bgcolor=Colors.purple, String text="Error occured"})
{
  return SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        backgroundColor: bgcolor,
        content: Text(text, style: TextStyle(color: Colors.white, fontSize: 15)));
}
