import 'package:flutter/material.dart';
class  RouteTranstions
{
static Route transtion1(Widget path) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => path,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1, 0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}