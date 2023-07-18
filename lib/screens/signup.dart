import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/constants.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/widgets/text_field.dart';
import '../widgets/custom_rich_text.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        const CustomTf(hintText: 'Username'),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTf(hintText: 'Email'),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTf(
                          hintText: 'Password',
                          obsText: true,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const CustomTf(
                          hintText: 'Confirm Password',
                          obsText: true,
                        ),
                        SizedBox(
                          height: 33.h,
                        ),
                        const MyButton(
                          buttonText: 'Sign Up',
                          buttonColor: Color(0xFF987EFF),
                          buttonWidth: 350,
                          buttonHeight: 50,
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
