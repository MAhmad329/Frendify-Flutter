import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Views/pin_verification_screen.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/widgets/text_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Phone Number Here',
                    style: kText1.copyWith(fontSize: 25.sp),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      'Enter the phone number associated with your account',
                      style: kText2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  const CustomTf(hintText: 'Phone Number'),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyButton(
                    buttonText: 'Send OTP',
                    buttonColor: primaryColor,
                    buttonWidth: 350,
                    buttonHeight: 50,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmailVerification(),
                      ),
                    ),
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
    );
  }
}
