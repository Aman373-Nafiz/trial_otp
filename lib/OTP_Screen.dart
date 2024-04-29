import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trial_otp/HomeScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTP_Screen extends StatefulWidget {
  String verificationId;
  OTP_Screen({super.key, required this.verificationId});

  @override
  State<OTP_Screen> createState() => _OTP_ScreenState();
}

class _OTP_ScreenState extends State<OTP_Screen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    TextEditingController txt1 = TextEditingController();
    TextEditingController txt2 = TextEditingController();
    TextEditingController txt3 = TextEditingController();
    TextEditingController txt4 = TextEditingController();
    TextEditingController txt5 = TextEditingController();
    TextEditingController txt6 = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Appbar',
            style: TextStyle(color: Colors.white, fontSize: 21),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myInputBox(context, txt1),
                myInputBox(context, txt2),
                myInputBox(context, txt3),
                myInputBox(context, txt4),
                myInputBox(context, txt5),
                myInputBox(context, txt6),
              ],
            ),
            SizedBox(
              height: h * 0.12,
            ),
            ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId!,
                      smsCode: '${txt1}${txt2}${txt3}${txt4}${txt5}${txt6}');
                  await auth.signInWithCredential(credential).then((value) =>
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home();
                      })));
                },
                child: Center(
                  child: Text('Verify'),
                ))
          ],
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 70,
    width: 60,
    child: TextField(
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 40),
      decoration: const InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}
