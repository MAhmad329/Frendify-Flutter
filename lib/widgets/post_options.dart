import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/bottom_sheet_lists.dart';
import 'bottom_sheet.dart';
import '../constants.dart';

class PostOptions extends StatefulWidget {
  const PostOptions(
    this.text,
    this.firstIcon,
    this.secondIcon, {
    this.secondText = "",
    this.moreOptions = false,
    this.toggleOption = false,
    super.key,
  });

  final String text;
  final IconData firstIcon;
  final IconData secondIcon;
  final String secondText;
  final bool moreOptions;
  final bool toggleOption;

  @override
  State<PostOptions> createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    widget.firstIcon,
                    size: 22.r,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (widget.moreOptions == false)
          Row(
            children: [
              Text(
                widget.secondText,
                style: kText2.copyWith(color: Colors.black26, fontSize: 14.sp),
              ),
              if (widget.toggleOption == false)
                Icon(
                  widget.secondIcon,
                  size: 22.r,
                  color: Colors.black26,
                ),
              if (widget.toggleOption == true)
                Switch(
                    activeColor: const Color(0xFF987EFF),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    })
            ],
          ),
        if (widget.moreOptions == true)
          InkWell(
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.r))),
                context: context,
                builder: (context) {
                  return BotSheet(
                    bottomBarList: addPostBottomBarList,
                  );
                },
              );
            },
            child: Row(
              children: [
                Text(
                  widget.secondText,
                  style:
                      kText2.copyWith(color: Colors.black26, fontSize: 14.sp),
                ),
                Icon(
                  widget.secondIcon,
                  size: 22.r,
                  color: Colors.black26,
                )
              ],
            ),
          )
      ],
    );
  }
}
