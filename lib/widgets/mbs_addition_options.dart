import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

additionalOptions(
    {required Function() onPressFunc1, required Function() onPressFunc2}) {
  return Wrap(
    children: [
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, bottom: 20.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: InkWell(
                onTap: onPressFunc1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Take a picture using the Camera',
                      style: kHeading.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: InkWell(
                onTap: onPressFunc2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Select from Gallery',
                      style: kHeading.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
