import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Otpbox extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  const Otpbox({super.key, this.onChanged, required this.controller});
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 50,
      height: 54,
      child: TextField(

        //onchanged

        onChanged: (this.onChanged!=null)?onChanged:(
          (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty) {
                        FocusScope.of(context).previousFocus();
                      }
                    }
        ),
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.secondary,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.primary,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Theme.of(context).colorScheme.primary),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 3, color: Theme.of(context).colorScheme.tertiary),
              borderRadius: BorderRadius.circular(10),
            )),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}
