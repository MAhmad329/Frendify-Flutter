import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/screens/reset_password.dart';
import 'package:frendify/widgets/code_circles.dart';
import 'package:frendify/widgets/constants.dart';
import 'package:frendify/widgets/button.dart';
import '../widgets/custom_rich_text.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

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
          'Email Verification',
          style: kText1.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Get Your Code',
                    style: kText1.copyWith(fontSize: 25.sp),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      'Enter the 4 digit code sent to your email address',
                      style: kText2.copyWith(fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const CodeCircles(),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyButton(
                    buttonText: 'Verify',
                    buttonColor: const Color(0xFF987EFF),
                    buttonWidth: 350,
                    buttonHeight: 50,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPassword(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const CustomRichText(
                    text1: "Didn't receive the code? ",
                    text2: 'Resend now',
                    clickable: true,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
