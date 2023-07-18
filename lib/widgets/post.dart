import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/screens/others_profile_screen.dart';
import 'package:frendify/widgets/constants.dart';
import 'bottom_sheet_lists.dart';
import 'bottom_sheet.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 15,
        color: const Color.fromRGBO(245, 245, 245, 1),
      ),
      Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UsersProfileScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                const AssetImage('assets/profile.jpeg'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ahmad',
                                  style: kHeading.copyWith(fontSize: 15.sp),
                                ),
                                Text(
                                  '1 Hour ago',
                                  style: kSubheading.copyWith(fontSize: 10.sp),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                      size: 25.r,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        showDragHandle: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.r))),
                        context: context,
                        builder: (context) {
                          return BotSheet(
                            bottomBarList: homePageBottomBarList,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: Text(
                        'Natural Market London is back to life.\n#London #UK',
                        style: kBasicText,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0.r),
                      child: Image(
                        fit: BoxFit.cover,
                        height: 175.h,
                        image: const AssetImage('assets/img_1.png'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 40.0.w),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: const Color(0xFF987EFF),
                                    size: 20.r,
                                  ),
                                  Text('25',
                                      style: TextStyle(
                                          color: const Color(0xFF987EFF),
                                          fontSize: 13.sp)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mode_comment_outlined,
                                  color: const Color.fromRGBO(189, 189, 189, 1),
                                  size: 20.r,
                                ),
                                Text('5',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: const Color.fromRGBO(
                                          189, 189, 189, 1),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.send,
                    size: 20.r,
                    color: const Color.fromRGBO(189, 189, 189, 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
