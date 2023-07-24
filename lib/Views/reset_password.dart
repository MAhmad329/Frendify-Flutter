import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/constants.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/widgets/text_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

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
          'Reset Password',
          style: kText1,
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
                    'New Password',
                    style: kText1.copyWith(fontSize: 25.sp),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    width: 300.w,
                    child: Text(
                      'New password must be different from previously used passwords',
                      style: kText2.copyWith(fontSize: 14.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
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
                    height: 20.h,
                  ),
                  const MyButton(
                    buttonText: 'Reset Password',
                    buttonColor: Color(0xFF987EFF),
                    buttonWidth: 350,
                    buttonHeight: 50,
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
