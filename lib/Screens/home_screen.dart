import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/search_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frendify/Screens/settings_screen.dart';
import '../constants.dart';
import 'add_post.dart';
import 'chats_screen.dart';
import 'feed_screen.dart';
import '../widgets/mbs_addition_options.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = const [
    FeedScreen(),
    SearchScreen(),
    Chats(),
    SettingsScreen(),
  ];
  XFile? imageFile;

  final iconList = <IconData>[
    Icons.home_outlined,
    Icons.search_sharp,
    Icons.chat_bubble_outline,
    Icons.settings,
  ];
  Color activeNavigationBarColor = primaryColor;
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
              backgroundColor: primaryColor,
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.r))),
                  context: context,
                  builder: (context) {
                    return additionalOptions(
                      onPressFunc1: () async {
                        Navigator.pop(context);
                        await pickImage(ImageSource.camera);
                        navigateToAddPost();
                      },
                      onPressFunc2: () async {
                        Navigator.pop(context);
                        await pickImage(ImageSource.gallery);
                        navigateToAddPost();
                      },
                    );
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
      body: screens[_bottomNavIndex],
    );
  }
}
