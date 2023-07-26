import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Controllers/auth.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import '../widgets/custom_rich_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String error = '';
  bool _emailValidated = true;
  bool _passwordValidated = true;
  bool _confirmPasswordValidated = true;
  bool showSpinner = false;

  Future<void> authenticateSignup() async {
    setState(
      () {
        _emailValidated = true;
        _passwordValidated = true;
        _confirmPasswordValidated = true;
        showSpinner = true;
      },
    );
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await Auth().signUp(
            email: _emailController.text, password: _passwordController.text);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your account has been created successfully.'),
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.popAndPushNamed(context, 'email_verification_screen');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          error = 'Email already exists';
          _emailValidated = false;
        } else if (e.code == 'invalid-email') {
          error = 'Invalid email format!';
          _emailValidated = false;
        } else if (e.code == 'weak-password') {
          error = 'Weak password. Try another one!';
          _passwordValidated = false;
        } else if (_emailController.text.isEmpty) {
          error = 'Email cannot be empty!';
          _emailValidated = false;
        } else if (_passwordController.text.isEmpty ||
            _confirmPasswordController.text.isEmpty) {
          error = 'Password cannot be empty!';
          _passwordValidated = false;
          _confirmPasswordValidated = false;
        } else if (e.code == 'network-request-failed') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('No Internet Connection!')),
              duration: Duration(seconds: 5),
            ),
          );
        } else {
          error = 'Undefined Error';
          _emailValidated = false;
          _passwordValidated = false;
          _confirmPasswordValidated = false;
        }
      }
    } else {
      error = 'Passwords do not match!';
      _passwordValidated = false;
      _confirmPasswordValidated = false;
    }
    setState(
      () {
        showSpinner = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
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
                            height: 20.h,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: kTextFieldDecoration.copyWith(
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.r)),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.r)),
                                  borderSide: const BorderSide(
                                    width: 2,
                                    color: Colors.red,
                                  ),
                                ),
                                errorText: _emailValidated ? null : error,
                                hintText: 'Email'),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: kTextFieldDecoration.copyWith(
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.r)),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.r)),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                              ),
                              errorText: _passwordValidated ? null : error,
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: kTextFieldDecoration.copyWith(
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.r)),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32.r)),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.red,
                                ),
                              ),
                              errorText:
                                  _confirmPasswordValidated ? null : error,
                              hintText: 'Confirm Password',
                            ),
                          ),
                          SizedBox(
                            height: 33.h,
                          ),
                          MyButton(
                            buttonText: 'Sign Up',
                            buttonColor: primaryColor,
                            buttonWidth: 350,
                            buttonHeight: 50,
                            onTap: authenticateSignup,
                          ),
                        ],
                      ),
                      const SizedBox(),
                      const CustomRichText(
                        text1: "Already have an account? ",
                        text2: 'Sign In',
                        clickable: true,
                        currentScreen: 'signup',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
