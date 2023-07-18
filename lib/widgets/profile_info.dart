import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.name,
    required this.following,
    required this.followers,
    required this.sales,
  });

  final String name;
  final String following;
  final String followers;
  final String sales;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: Column(
        children: [
          SizedBox(
            height: 33.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage: const AssetImage('assets/profile.jpeg'),
                    radius: 60.r,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '@$name',
                    style: kText1.copyWith(
                        fontSize: 18.sp, color: const Color(0xffACACAC)),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Column(
                  children: [
                    Text(
                      following,
                      style: kText1.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Following',
                      style: kHeading.copyWith(
                        color: const Color(0xffBDBDBD),
                        fontSize: 15.sp,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Column(
                  children: [
                    Text(
                      followers,
                      style: kText1.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Followers',
                      style: kHeading.copyWith(
                        fontSize: 15.sp,
                        color: const Color(0xffBDBDBD),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Column(
                  children: [
                    Text(
                      sales,
                      style: kText1.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      'Sales',
                      style: kHeading.copyWith(
                        fontSize: 15.sp,
                        color: const Color(0xffBDBDBD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
