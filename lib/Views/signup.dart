import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Controllers/auth.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import '../widgets/custom_rich_text.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '';
    String pass = '';
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Image(
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.scaleDown,
                        image: const AssetImage('assets/logo.jpeg'),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'Create new Account',
                          style: kText1.copyWith(fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        // const CustomTf(hintText: 'Username'),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        TextField(
                          onChanged: (value) {
                            email = value;
                          },
                          decoration:
                              kTextFieldDecoration.copyWith(hintText: 'Email'),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        TextField(
                          onChanged: (value) {
                            pass = value;
                          },
                          obscureText: true,
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Password'),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        // const CustomTf(
                        //   hintText: 'Confirm Password',
                        //   obsText: true,
                        // ),
                        SizedBox(
                          height: 33.h,
                        ),
                        MyButton(
                          buttonText: 'Sign Up',
                          buttonColor: const Color(0xFF987EFF),
                          buttonWidth: 350,
                          buttonHeight: 50,
                          onTap: () async {
                            try {
                              await Auth().signUp(email: email, password: pass);
                              if (context.mounted) {
                                Navigator.popAndPushNamed(
                                    context, 'login_screen');
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(),
                    const CustomRichText(
                      text1: "Don't have an Account? ",
                      text2: 'Sign Up',
                      clickable: true,
                      screen: 'signup',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
