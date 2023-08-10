import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import '../widgets/custom_rich_text.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = '';
  bool _validated = true;
  bool showSpinner = false;

  Future<void> authenticateLogin() async {
    try {
      setState(
        () {
          _validated = true;
          showSpinner = true;
        },
      );
      await Auth().signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text);

      if (mounted) {
        if (Auth().currentUser!.emailVerified) {
          Navigator.popAndPushNamed(context, 'home_screen');
        } else {
          Navigator.popAndPushNamed(context, 'email_verification_screen');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
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
        error = 'Email Or Password Does Not Match!';
        _validated = false;
      }
    }
    setState(() => showSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        color: primaryColor,
        progressIndicator: CircularProgressIndicator(
          color: primaryColor,
        ),
        inAsyncCall: showSpinner,
        child: SafeArea(
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
                          const CustomRichText(
                            text1: 'Sign In to ',
                            text2: 'Frendify',
                            clickable: false,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: kTextFieldDecoration.copyWith(
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
                              errorText: _validated ? null : error,
                              hintText: 'Password',
                            ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Align(
                            alignment: width > 500
                                ? Alignment.center
                                : Alignment.centerRight,
                            child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'forget_password_screen');
                                },
                                child: Text('Forgot Your Password?',
                                    style: kBasicText)),
                          ),
                          SizedBox(
                            height: 33.h,
                          ),
                          MyButton(
                            buttonText: 'Sign in',
                            buttonColor: primaryColor,
                            buttonWidth: 350,
                            buttonHeight: 50,
                            onTap: authenticateLogin,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      const CustomRichText(
                        text1: "Don't have an Account? ",
                        text2: 'Sign Up',
                        clickable: true,
                        currentScreen: 'login',
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
