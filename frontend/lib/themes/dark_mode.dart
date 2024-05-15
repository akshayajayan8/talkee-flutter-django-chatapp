import 'package:flutter/material.dart';
const primary=Color.fromARGB(197, 208, 148, 243);
const secondary=Color.fromARGB(255, 189, 189, 189);

ThemeData darkMode =ThemeData(

  primarySwatch:  Colors.purple,
    colorScheme:const ColorScheme.dark(
        background: Colors.white,
        primary: primary,
        secondary:  secondary,
        tertiary: Colors.white),
    scaffoldBackgroundColor: Colors.black,
    textTheme:const TextTheme(
      bodyMedium: TextStyle(
                      fontFamily: 'Poppinsthin',
                      color: primary,
                      fontSize: 25),
      bodySmall: TextStyle(
                          color: secondary,
                          fontFamily: 'Poppinsthin',
                          fontSize: 15),
      titleLarge: TextStyle(
                          fontFamily: 'Poppins',
                          color:primary,
                          fontSize: 50)
                  
    ));
