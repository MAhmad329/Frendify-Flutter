import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/chat_bubble.dart';
import 'package:frendify/widgets/constants.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Column(
            children: [
              Text(
                'Alex Jhons',
                style: kText1.copyWith(fontSize: 18.sp),
              ),
              Text(
                'Active 5 hours ago',
                style: kText2.copyWith(
                  fontSize: 10.sp,
                  color: const Color(0xffbdbdbd),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: const [
                      ChatBubble(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text:
                            'Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text:
                            'Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text:
                            'Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text: 'How was the concert?',
                        isCurrentUser: false,
                      ),
                      ChatBubble(
                        text:
                            'Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!Awesome! Next time you gotta come as well!',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Ok, when is the next date?',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'They\'re playing on the 20th of November',
                        isCurrentUser: true,
                      ),
                      ChatBubble(
                        text: 'Let\'s do it!',
                        isCurrentUser: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: "Type your message here...",
                            hintStyle: const TextStyle(
                              color: Color(0xFFBDBDBD),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.r),
                                borderSide: BorderSide.none),
                            fillColor: const Color(0xFFF1F1F1),
                            filled: true,
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Color(0xFFBDBDBD),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0.h),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF987EFF),
                          maxRadius: 20.r,
                          child: Icon(
                            Icons.send,
                            size: 15.r,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
