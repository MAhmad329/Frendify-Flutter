import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalScroll extends StatelessWidget {
  const HorizontalScroll({
    super.key,
    required this.images,
    required this.builtItems,
  });

  final List<Image> images;
  final Widget? Function(BuildContext, int) builtItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 11.w,
          );
        },
        itemBuilder: builtItems,
      ),
    );
  }
}
