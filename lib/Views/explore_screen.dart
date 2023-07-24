import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/widgets/search_bar.dart';
import '../constants.dart';
import '../widgets/horizontal_scroll.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  Future<bool> _onWillPop() async {
    Navigator.pushReplacementNamed(context, 'home_screen');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Image> profileimages = [
      Image.asset('assets/img_1.png'),
      Image.asset('assets/profile.jpeg'),
      Image.asset('assets/img_1.png'),
      Image.asset('assets/profile.jpeg'),
      Image.asset('assets/img_1.png'),
      Image.asset('assets/profile.jpeg'),
      Image.asset('assets/img_1.png'),
      Image.asset('assets/profile.jpeg'),
    ];
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: CustomSearchbar(searchController: _searchController),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Scooper',
                        style: kText1.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
                      InkWell(
                        child: Text(
                          'View all',
                          style: kHeading.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xffBDBDBD),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  HorizontalScroll(
                    images: profileimages,
                    builtItems: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image(
                          width: 92.w,
                          fit: BoxFit.cover,
                          image: profileimages[index].image,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Trending',
                    style: kText1.copyWith(
                        fontWeight: FontWeight.w500, fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#London',
                        style: kText3.copyWith(
                            fontSize: 18.sp, color: const Color(0xffbdbdbd)),
                      ),
                      InkWell(
                        child: Text(
                          'View all',
                          style: kHeading.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xffBDBDBD),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HorizontalScroll(
                    images: profileimages,
                    builtItems: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image(
                          width: 190.w,
                          fit: BoxFit.cover,
                          image: profileimages[index].image,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#London',
                        style: kText3.copyWith(
                            fontSize: 18.sp, color: const Color(0xffbdbdbd)),
                      ),
                      InkWell(
                        child: Text(
                          'View all',
                          style: kHeading.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xffBDBDBD),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HorizontalScroll(
                    images: profileimages,
                    builtItems: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image(
                          width: 190.w,
                          fit: BoxFit.cover,
                          image: profileimages[index].image,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#London',
                        style: kText3.copyWith(
                            fontSize: 18.sp, color: const Color(0xffbdbdbd)),
                      ),
                      InkWell(
                        child: Text(
                          'View all',
                          style: kHeading.copyWith(
                            fontSize: 10.sp,
                            color: const Color(0xffBDBDBD),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HorizontalScroll(
                    images: profileimages,
                    builtItems: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0.r),
                        child: Image(
                          width: 190.w,
                          fit: BoxFit.cover,
                          image: profileimages[index].image,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
