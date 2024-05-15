import 'package:chatapp/components/AppButton.dart';
import 'package:chatapp/components/OtpBox.dart';
import 'package:chatapp/server/apiconnect.dart';
import 'package:chatapp/server/essentialdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OtpVerify extends StatelessWidget {
  final String phone;
  OtpVerify({
    super.key,
    required this.phone,
  });
  //controllers
  final TextEditingController dig1 = TextEditingController();
  final TextEditingController dig2 = TextEditingController();
  final TextEditingController dig3 = TextEditingController();
  final TextEditingController dig4 = TextEditingController();
  final TextEditingController dig5 = TextEditingController();
  final TextEditingController dig6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(197, 195, 124, 236),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Sizedbox

                SizedBox(height: 30),

                //decoroationimage

                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/otpicon.png'),
                  ),
                ),
                Text(
                  'Enter the otp that has sent to $phone for verification',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                //sizedbox

                SizedBox(height: 30),

                //otptextfield
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Otpbox(
                          controller: dig1,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                          }),
                      Otpbox(
                        controller: dig2,
                      ),
                      Otpbox(
                        controller: dig3,
                      ),
                      Otpbox(
                        controller: dig4,
                      ),
                      Otpbox(controller: dig5),
                      Otpbox(
                          controller: dig6,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              FocusScope.of(context).previousFocus();
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AppButton(
                    onTap: () {
                      USERPHONE = phone;
                      String otpEntered = dig1.text +
                          dig2.text +
                          dig3.text +
                          dig4.text +
                          dig5.text +
                          dig6.text;
                      print(otpEntered);
                      userAuth(context, phone, otpEntered);
                    },
                    text: "VERIFY"),
                //SizedBox
                SizedBox(height: 30),
                Text(
                  'Didnt get the Code?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Poppinsthin',
                      letterSpacing: 5,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                //Register button
                GestureDetector(
                    onTap: () {
                      print('code resent');
                      resendOtp(context, phone);
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 5,
                              color: Colors.blue,
                            )
                          ],
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 25),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
