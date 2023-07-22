import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, 'home_screen');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).popAndPushNamed('home_screen');
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Account',
                    style: kText1.copyWith(
                      color: const Color(0xffBDBDBD),
                      fontSize: 20.sp,
                    ),
                  ),
                  Divider(
                    thickness: 1.h,
                    height: 15.h,
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Password',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Email',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Blocked Users',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delete Account',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'Other Settings',
                    style: kText1.copyWith(
                      color: const Color(0xffBDBDBD),
                      fontSize: 20.sp,
                    ),
                  ),
                  Divider(
                    thickness: 1.h,
                    height: 15.h,
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Earning Statistics',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Current Hiring',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Location',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clear Search History',
                            style: kText3.copyWith(fontSize: 18.sp),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            color: const Color(0xffbdbdbd),
                            size: 30.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.popAndPushNamed(context, 'login_screen');
                  }
                },
                child: SizedBox(
                  height: 100.h,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xffbdbdbd),
                        foregroundColor: Colors.white,
                        radius: 26.r,
                        child: const Icon(Icons.logout),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5.w)),
                      Text(
                        'Sign Out',
                        style: kText1.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
