import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/constants.dart';
import '../Models/notifications_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: kHeading.copyWith(fontSize: 20.sp),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  notification.day,
                  style: kHeading.copyWith(
                    fontSize: 15.sp,
                    color: const Color(0xffbdbdbd),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: notifications
                        .where((item) => item.day == notification.day)
                        .map(
                      (notification) {
                        return ListTile(
                          horizontalTitleGap: 0.w,
                          contentPadding: const EdgeInsets.all(0),
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 15.0.h),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage(notification.imageURL),
                                  radius: 35.r,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          text: notification.name,
                                          style: kText1.copyWith(
                                            color: const Color(0xff48525B),
                                            fontSize: 14.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ', ${notification.notificationText}',
                                              style: kText2.copyWith(
                                                color: const Color(0xff48525B),
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        notification.time,
                                        style: kText2.copyWith(
                                          color: const Color(0xffAFAFAF),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // Handle onTap action
                          },
                          // subtitle:
                          trailing: InkWell(
                            customBorder: const CircleBorder(),
                            child: Icon(
                              Icons.more_vert,
                              size: 25.r,
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
