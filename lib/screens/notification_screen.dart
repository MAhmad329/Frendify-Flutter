import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/constants.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> notifications = [
    {
      'day': 'Today',
      'notifications': [
        {
          'id': 1,
          'person': {
            'name': 'John Doe',
            'image': 'assets/profile.jpeg',
          },
          'description':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'time': '10:00 AM',
        },
        {
          'id': 2,
          'person': {
            'name': 'Jane Smith',
            'image': 'assets/profile.jpeg',
          },
          'description':
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          'time': '12:30 PM',
        },
      ],
    },
    {
      'day': 'Yesterday',
      'notifications': [
        {
          'id': 3,
          'person': {
            'name': 'Alice Johnson',
            'image': 'assets/profile.jpeg',
          },
          'description':
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
          'time': '9:45 AM',
        },
      ],
    },
    {
      'day': 'This Weekend',
      'notifications': [
        {
          'id': 4,
          'person': {
            'name': 'Alice Johnson',
            'image': 'assets/profile.jpeg',
          },
          'description':
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
          'time': '3:00 PM',
        },
      ],
    },
    // Add more days and notifications here...
  ];

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
          final notificationDay = notifications[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  notificationDay['day'],
                  style: kHeading.copyWith(
                    fontSize: 15.sp,
                    color: const Color(0xffbdbdbd),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Column(
                    children: (notificationDay['notifications']
                            as List<Map<String, dynamic>>)
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
                                  backgroundImage: AssetImage(
                                    notification['person']['image'],
                                  ),
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
                                          text:
                                              '${notification['person']['name']}',
                                          style: kText1.copyWith(
                                              color: const Color(0xff48525B),
                                              fontSize: 14.sp),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  ', ${notification['description']}',
                                              style: kText2.copyWith(
                                                  color:
                                                      const Color(0xff48525B),
                                                  fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        notification['time'],
                                        style: kText2.copyWith(
                                            color: const Color(0xffAFAFAF),
                                            fontSize: 12.sp),
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
