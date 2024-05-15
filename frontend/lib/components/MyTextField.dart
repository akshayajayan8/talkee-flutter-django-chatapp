import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final IconData icon;
  final String hintTxt;
  final TextInputType inputType;
  final TextEditingController controller;
  final validator;
  final readOnly;
  final onTap;
  MyTextField(
      {super.key,
      required this.icon,
      required this.hintTxt,
      required this.inputType,
      required this.controller,
      this.validator,
      this.readOnly=false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        keyboardType: inputType,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          label: Text(hintTxt),
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
