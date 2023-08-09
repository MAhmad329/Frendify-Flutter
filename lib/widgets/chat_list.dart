import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/chatdetails_screen.dart';
import 'package:frendify/constants.dart';

class ConversationList extends StatefulWidget {
  const ConversationList(
      {super.key,
      required this.name,
      required this.messageText,
      required this.imageUrl,
      required this.time,
      required this.isMessageRead});

  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final bool isMessageRead;
  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatDetailsScreen(),
          ),
        );
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 10.h),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.imageUrl),
                    maxRadius: 28.r,
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: kHeading.copyWith(fontSize: 15.sp),
                          ),
                          SizedBox(height: 6.h),
                          Text(widget.messageText,
                              style: kBasicText.copyWith(
                                fontSize: 12.sp,
                                color: widget.isMessageRead
                                    ? Colors.black45
                                    : Colors.black,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: widget.isMessageRead
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                if (widget.isMessageRead)
                  Icon(
                    Icons.done_all,
                    color: const Color(0xFF987EFF),
                    size: 18.r,
                  ),
                if (!widget.isMessageRead)
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(152, 126, 255, 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '3', // Replace '3' with the actual count of unread messages
                      style: TextStyle(
                        color: const Color(0xFF987EFF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
