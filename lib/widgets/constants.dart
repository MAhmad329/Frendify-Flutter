import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle kBasicText =
    TextStyle(color: Colors.black, fontSize: 12.sp, fontFamily: 'Poppins');
TextStyle kHeading = TextStyle(
    fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 15.sp);
TextStyle kSubheading =
    TextStyle(fontSize: 10.sp, color: Colors.black38, fontFamily: 'Poppins');

TextStyle kText1 = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w600,
  fontSize: 20.sp,
  fontFamily: 'Poppins',
);

TextStyle kText2 = TextStyle(
  color: Colors.black54,
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  fontFamily: 'Poppins',
);

TextStyle kText3 = TextStyle(
  color: const Color(0xff323232),
  fontWeight: FontWeight.w500,
  fontFamily: 'Poppins',
  fontSize: 18.sp,
);

const ButtonStyle kButton1 =
    ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF987EFF)));

InputDecoration kPostTextFieldDecoration = InputDecoration(
  alignLabelWithHint: true,
  hintText: 'Describe your post',
  hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
  filled: true,
  fillColor: const Color(0xFFF5F5F5),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'hint text',
  hintStyle: TextStyle(color: Colors.grey),
  filled: true,
  fillColor: Color.fromRGBO(152, 126, 255, 0.10),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF987EFF), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
