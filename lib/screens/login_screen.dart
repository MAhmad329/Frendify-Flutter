import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/screens/home_screen.dart';
import 'package:frendify/widgets/constants.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/widgets/text_field.dart';
import '../widgets/custom_rich_text.dart';
import 'forgetpassword.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
                        const CustomRichText(
                          text1: 'Sign In to ',
                          text2: 'Frendify',
                          clickable: false,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const CustomTf(hintText: "Email"),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTf(
                          hintText: "Password",
                          obsText: true,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgetPassword()));
                              },
                              child: Text('Forgot Your Password?',
                                  style: kBasicText)),
                        ),
                        SizedBox(
                          height: 33.h,
                        ),
                        MyButton(
                          buttonText: 'Sign in',
                          buttonColor: const Color(0xFF987EFF),
                          buttonWidth: 350,
                          buttonHeight: 50,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
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
                      screen: 'login',
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
