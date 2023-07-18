import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';

class BotSheetOptions extends StatelessWidget {
  const BotSheetOptions({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
    this.textOnly = false,
  });

  final IconData icon;
  final String text1;
  final String text2;
  final bool textOnly;

  @override
  Widget build(BuildContext context) {
    if (textOnly == false) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0.h),
        child: InkWell(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: Icon(
                  icon,
                  size: 30.r,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text1,
                    style: kHeading.copyWith(fontSize: 16.sp),
                  ),
                  Text(
                    text2,
                    style: kSubheading.copyWith(fontSize: 10.sp),
                  )
                ],
              ),
            ],
          ),
          onTap: () {},
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text1,
                style: kHeading.copyWith(
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
