import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trial_otp/OTP_Screen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(PhoneNumber());
}

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  final PhoneNumber = TextEditingController();
  Widget build(BuildContext context) {
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
          body: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Phone Number',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 50,
                  width: 260,
                  child: TextFormField(
                    controller: PhoneNumber,
                    decoration: InputDecoration(
                      // labelText: 'Enter your text',
                      hintText: 'Phone Number',
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 22,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () async {
                      print('+88${PhoneNumber.text.toString()}');
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '+88${PhoneNumber.text.toString()}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return OTP_Screen(verificationId: verificationId);
                          }));
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Center(
                      child: Text('Verify'),
                    ))
              ],
            ),
          )),
    );
  }
}
