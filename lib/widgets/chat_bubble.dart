import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/constants.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {Key? key,
      required this.text,
      required this.isCurrentUser,
      required this.time})
      : super(key: key);

  final String text;
  final DateTime time;
  final bool isCurrentUser;

  String formatDate(DateTime timestamp) {
    final format = DateFormat.jm(); // Customize the format as needed
    return format.format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isCurrentUser ? 64.0.w : 16.0.w,
        11.h,
        isCurrentUser ? 16.0.w : 64.0.w,
        11.h,
      ),
      child: Align(
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? const Color(0xFF987EFF)
                    : const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
                child: Text(
                  text,
                  style: kText2.copyWith(
                      color: isCurrentUser ? Colors.white : Colors.black,
                      fontSize: 16.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                formatDate(time),
                style: kText2.copyWith(fontSize: 11.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
