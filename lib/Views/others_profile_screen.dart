import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/button.dart';
import 'package:frendify/widgets/post.dart';
import '../widgets/profile_info.dart';

class UsersProfileScreen extends StatelessWidget {
  const UsersProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text('Ahmad'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz),
              ),
            ],
          ),
          body: Column(
            children: [
              const ProfileInfo(),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    buttonText: 'Follow',
                    buttonColor: const Color(0xFF987EFF),
                    buttonWidth: 110.w,
                    buttonHeight: 30.h,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  MyButton(
                      buttonText: 'Follow',
                      buttonColor: Colors.white,
                      borderColor: const Color(0xFF987EFF),
                      textColor: const Color(0xFF987EFF),
                      buttonWidth: 80.w,
                      buttonHeight: 30.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  MyButton(
                      buttonText: 'Follow',
                      buttonColor: Colors.white,
                      borderColor: const Color(0xFF987EFF),
                      textColor: const Color(0xFF987EFF),
                      buttonWidth: 80.w,
                      buttonHeight: 30.h),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
                child: SizedBox(
                  height: 50,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      indicatorColor: const Color(0xFF987EFF),
                      unselectedLabelColor: const Color(0xffbdbdbd),
                      labelColor: const Color(0xFF987EFF),
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.grid_view,
                            size: 20.r,
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.view_headline_sharp,
                            size: 20.r,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // create widgets for each tab bar here
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: TabBarView(
                    children: [
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.5,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                        ],
                      ),

                      // second tab bar viiew widget
                      const SingleChildScrollView(
                        child: Column(
                          children: [
                            Post(),
                            Post(),
                            Post(),
                          ],
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.5,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/profile.jpeg'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0.r),
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/img_1.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
