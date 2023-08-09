import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {Key? key, required this.hintText, required this.onSubmitted})
      : super(key: key);

  final String hintText;
  final Function(String) onSubmitted; // Add this line to receive the comment

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.5.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: commentController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFFBDBDBD),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.r),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color(0xFFF1F1F1),
                  filled: true,
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0.h),
              child: InkWell(
                onTap: () {
                  final commentText = commentController.text.trim();
                  if (commentText.isNotEmpty) {
                    onSubmitted(
                        commentText); // Call the callback function with the comment
                    commentController.clear(); // Clear the text field
                  }
                },
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  maxRadius: 20.r,
                  child: Icon(
                    Icons.send,
                    size: 15.r,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
