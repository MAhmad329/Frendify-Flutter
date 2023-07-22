import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:frendify/screens/settings_screen.dart';
import '../widgets/constants.dart';
import 'add_post.dart';
import 'chats_screen.dart';
import 'explore_screen.dart';
import 'feed_screen.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? imageFile;

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.search_sharp,
    Icons.chat_bubble_outline,
    Icons.settings,
  ];
  Color activeNavigationBarColor = const Color(0xFF987EFF);
  Color inactiveNavigationBarColor = Colors.grey;

  int _bottomNavIndex = 0;
  bool isNavigationBarVisible = true;

  pickImage(source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        setState(() => imageFile = null); // Reset imageFile to null
        return;
      }
      final imageTemp = XFile(image.path);
      setState(() => imageFile = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  navigateToAddPost() async {
    if (imageFile != null) {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPost(
              picture: imageFile,
            ),
          ),
        );
      }
    } else {
      setState(() {
        _bottomNavIndex = 0;
      });
    }
  }

  additionalPostOption() {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0.w, bottom: 20.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: InkWell(
                  onTap: () async {
                    await pickImage(ImageSource.camera);
                    navigateToAddPost();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Take a picture using the Camera',
                        style: kHeading.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: InkWell(
                  onTap: () async {
                    await pickImage(ImageSource.gallery);
                    navigateToAddPost();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select from Gallery',
                        style: kHeading.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: isNavigationBarVisible,
        child: SizedBox(
          height: 56.h,
          width: 56.w,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF987EFF),
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.r))),
                  context: context,
                  builder: (context) {
                    return additionalPostOption();
                  },
                );
              },
              child: Icon(
                Icons.video_call_outlined,
                color: Colors.white,
                size: 20.r,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: isNavigationBarVisible
          ? AnimatedBottomNavigationBar.builder(
              itemCount: iconList.length,
              onTap: (index) => setState(() {
                _bottomNavIndex = index;
                if (_bottomNavIndex == 2 || _bottomNavIndex == 3) {
                  isNavigationBarVisible = false;
                } else {
                  isNavigationBarVisible = true;
                }
              }),
              tabBuilder: (index, isActive) {
                final color = isActive
                    ? activeNavigationBarColor
                    : inactiveNavigationBarColor;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24.r,
                      color: color,
                    ),
                  ],
                );
              },
              elevation: 0,
              activeIndex: _bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              height: 75,
              backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
              blurEffect: false,
              notchMargin: 10.r,
            )
          : null,
      body: LazyLoadIndexedStack(
        index: _bottomNavIndex,
        children: const [
          FeedScreen(),
          ExploreScreen(),
          Chats(),
          SettingsScreen(),
        ],
      ),
    );
  }
}
