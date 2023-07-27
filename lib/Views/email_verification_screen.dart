import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Controllers/auth.dart';
import 'package:frendify/Views/home_screen.dart';

import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = Auth().currentUser!.emailVerified;
    sendEmailVerification();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> sendEmailVerification() async {
    if (!isEmailVerified) {
      try {
        await Auth().sendVerificationEmail();
        setState(() => canResendEmail = false);
        await Future.delayed(const Duration(seconds: 30));
        if (mounted) {
          setState(() => canResendEmail = true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
              ),
            ),
          );
        }
      }

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkEmailVerified(),
      );
    }
  }

  Future<void> checkEmailVerified() async {
    final currentUser = Auth().currentUser;
    if (currentUser != null) {
      await currentUser.reload();
      if (mounted) {
        setState(() {
          isEmailVerified = currentUser.emailVerified;
        });

        if (isEmailVerified) {
          timer?.cancel();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomeScreen()
      : Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Email Verification'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
            elevation: 2,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'A verification email has been sent to your email!',
                  style: kText2.copyWith(
                    fontSize: 15.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.h,
                ),
                MyButton(
                  buttonText: 'Resend Email',
                  buttonColor: canResendEmail ? primaryColor : Colors.grey,
                  buttonWidth: 350,
                  buttonHeight: 50,
                  onTap: canResendEmail ? sendEmailVerification : null,
                ),
                SizedBox(
                  height: 5.h,
                ),
                MyButton(
                    buttonText: 'Cancel',
                    buttonColor: Colors.white,
                    textColor: Colors.black54,
                    buttonWidth: 200,
                    buttonHeight: 50,
                    onTap: () {
                      Auth().signOut();
                      Navigator.popAndPushNamed(context, 'login_screen');
                    }),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  canResendEmail
                      ? 'You can resend the email now.'
                      : 'You can resend the email after 30 seconds.',
                  style: kText2.copyWith(
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ),
        );
}
