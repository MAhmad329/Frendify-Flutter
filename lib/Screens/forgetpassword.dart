import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _validated = true;
  String error = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Forget Password',
          style: kText1.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ModalProgressHUD(
          color: primaryColor,
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Email Address Here',
                      style: kText1.copyWith(fontSize: 25.sp),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 300.w,
                      child: Text(
                        'Enter the email address associated with your account',
                        style: kText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: kTextFieldDecoration.copyWith(
                          errorText: _validated ? null : error,
                          hintText: 'Email'),
                    ),
                    //const CustomTf(hintText: 'Email'),
                    SizedBox(
                      height: 20.h,
                    ),
                    MyButton(
                      buttonText: 'Reset Password',
                      buttonColor: primaryColor,
                      buttonWidth: 350,
                      buttonHeight: 50,
                      onTap: () async {
                        try {
                          setState(() {
                            _validated = true;
                            showSpinner = true;
                          });
                          await Auth().resetPassword(
                            email: _emailController.text.trim(),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                    child:
                                        Text('Password Reset Email Was Sent!')),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          _validated = false;
                          if (e.code == 'user-not-found') {
                            error = 'User Not Found';
                          } else if (e.code == 'invalid-email') {
                            error = 'Invalid Email Format';
                          } else if (e.code == 'network-request-failed') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text(
                                      'Failed To Connect To Internet. Please Check Your Connection!.'),
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else {
                            error = 'Email Field is Empty!';
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      },
                    ),

                    SizedBox(
                      height: 75.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
