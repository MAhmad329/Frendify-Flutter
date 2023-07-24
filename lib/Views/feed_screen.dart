import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Views/notification_screen.dart';
import 'package:frendify/Views/myprofile_screen.dart';
import '../widgets/post.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyProfileScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 25.r,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10.0.w),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.black,
                  size: 25.r,
                ),
              ),
            ),
          ],
          title: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: TabBar(
              unselectedLabelStyle: TextStyle(fontSize: 14.sp),
              indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 1.5.w, color: const Color(0xFF987EFF)),
                insets: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              ),
              indicatorWeight: 2.w,
              labelColor: const Color(0xFF987EFF),
              unselectedLabelColor: Colors.grey,
              splashFactory: NoSplash.splashFactory,
              labelStyle: TextStyle(fontSize: 14.sp),
              labelPadding: EdgeInsets.only(bottom: 4.h),
              padding: EdgeInsets.only(bottom: 10.h),
              tabs: const [
                Tab(text: 'Featured'),
                Tab(text: 'Following'),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
        ),
        resizeToAvoidBottomInset: false,
        body: const SafeArea(
          bottom: false,
          child: TabBarView(
            children: [
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Post(),
                    Post(),
                    Post(),
                    Post(),
                  ],
                ),
              ),
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Post(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
