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
  String error = '';
  bool _validated = true;
  bool showSpinner = false;

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
                            height: 40.h,
                          ),
                          // const CustomTf(hintText: 'Username'),
                          // SizedBox(
                          //   height: 12.h,
                          // ),
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
                                errorText: _validated ? null : '',
                                errorStyle: TextStyle(height: 0.h),
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
                              errorText: _validated ? null : error,
                              hintText: 'Password',
                            ),
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
                                setState(
                                  () {
                                    _validated = true;
                                    showSpinner = true;
                                  },
                                );
                                await Auth().signUp(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Your account has been created successfully.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                  Navigator.popAndPushNamed(
                                      context, 'login_screen');
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'email-already-in-use') {
                                  error = 'Email already exists';
                                  _validated = false;
                                } else if (e.code == 'weak-password') {
                                  error = 'Weak password. Try another one!';
                                  _validated = false;
                                } else if (_emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  error = 'One or more fields are empty!';
                                  _validated = false;
                                } else if (e.code == 'network-request-failed') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(
                                          child:
                                              Text('No Internet Connection!')),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                } else {
                                  error = 'Invalid email format';
                                  _validated = false;
                                }
                              }
                              setState(
                                () {
                                  showSpinner = false;
                                },
                              );
                            },
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
