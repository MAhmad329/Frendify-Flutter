import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Authentication/auth.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String error = '';
  bool _emailValidated = true;
  bool _passwordValidated = true;
  bool _confirmPasswordValidated = true;
  bool _usernameValidated = true;
  bool _nameValidated = true;
  bool showSpinner = false;

  bool _isUsernameValid(String username) {
    final RegExp validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
    return validCharacters.hasMatch(username);
  }

  Future<void> authenticateSignup() async {
    setState(() {
      _emailValidated = true;
      _passwordValidated = true;
      _confirmPasswordValidated = true;
      _usernameValidated = true;
      _nameValidated = true;
      showSpinner = true;
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      error = 'Passwords Don\'t Match!';
      _passwordValidated = false;
      _confirmPasswordValidated = false;
    } else if (_nameController.text.isEmpty) {
      error = 'Name Cannot Be Empty!';
      _nameValidated = false;
    } else if (_emailController.text.isEmpty) {
      error = 'Email Cannot Be Empty!';
      _emailValidated = false;
    } else if (_usernameController.text.isEmpty) {
      error = 'Username cannot be empty!';
      _usernameValidated = false;
    } else if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      error = 'Password Cannot Be Empty!';
      _passwordValidated = false;
      _confirmPasswordValidated = false;
    } else if (!_isUsernameValid(_usernameController.text)) {
      error = 'Only letters and numbers are allowed.';
      _usernameValidated = false;
    } else {
      try {
        final available =
            await Auth().checkUsernameAvailability(_usernameController.text);
        if (available == true) {
          await signUpWithEmailAndPassword();
        } else {
          error = 'Username already taken!';
          _usernameValidated = false;
        }
      } on FirebaseAuthException catch (e) {
        handleAuthException(e);
      }
    }
    setState(() => showSpinner = false);
  }

  Future<void> signUpWithEmailAndPassword() async {
    try {
      await Auth().signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        username: _usernameController.text,
        name: _nameController.text.trim(),
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your Account Has Been Created Successfully.'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.popAndPushNamed(context, 'email_verification_screen');
      }
    } on FirebaseAuthException catch (e) {
      handleAuthException(e);
    }
  }

  void handleAuthException(FirebaseAuthException e) {
    setState(() {
      if (e.code == 'email-already-in-use') {
        error = 'Email Already Exists';
        _emailValidated = false;
      } else if (e.code == 'invalid-email') {
        error = 'Invalid Email Format!';
        _emailValidated = false;
      } else if (e.code == 'weak-password') {
        error = 'Weak Password. Try Another One!';
        _passwordValidated = false;
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
        _usernameValidated = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ModalProgressHUD(
          color: primaryColor,
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryColor,
          ),
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
                            controller: _nameController,
                            decoration: kTextFieldDecoration.copyWith(
                                errorText: _nameValidated ? null : error,
                                hintText: 'Full Name'),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextField(
                            controller: _usernameController,
                            decoration: kTextFieldDecoration.copyWith(
                                errorText: _usernameValidated ? null : error,
                                hintText: 'Username'),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: kTextFieldDecoration.copyWith(
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
