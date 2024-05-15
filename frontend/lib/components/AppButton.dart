import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppButton extends StatelessWidget {
  final onTap;
  final String text;
  const AppButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
            // padding: MaterialStateProperty.all(
            //     EdgeInsets.symmetric(horizontal: 60, vertical: 20)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
                side: MaterialStateProperty.all(BorderSide(
                  color:Theme.of(context).colorScheme.tertiary,
                  width:2
                  ))),
          
        onPressed: onTap,
        child: Text(text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 20,
            )));
  }
}
