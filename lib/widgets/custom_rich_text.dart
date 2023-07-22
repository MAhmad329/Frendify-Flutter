import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/constants.dart';
import 'package:frendify/screens/login_screen.dart';
import 'package:frendify/screens/signup.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    super.key,
    required this.text1,
    required this.text2,
    required this.clickable,
    this.screen,
  });
  final String text1;
  final String text2;
  final String? screen;
  final bool clickable;

  @override
  Widget build(BuildContext context) {
    TapGestureRecognizer checkScreen() {
      if (screen == 'login') {
        return TapGestureRecognizer()
          ..onTap = () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Signup()));
      } else if (screen == 'signup') {
        return TapGestureRecognizer()
          ..onTap = () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        return TapGestureRecognizer();
      }
    }

    return RichText(
      text: TextSpan(
        text: text1,
        style: clickable
            ? kText2.copyWith(fontSize: 14.sp)
            : kText1.copyWith(fontSize: 20.sp),
        children: <TextSpan>[
          TextSpan(
              text: text2,
              recognizer: checkScreen(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: clickable ? 16.sp : 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF987EFF),
              )),
        ],
      ),
    );
  }
}
