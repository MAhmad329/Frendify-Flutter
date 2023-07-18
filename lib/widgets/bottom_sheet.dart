import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotSheet extends StatelessWidget {
  const BotSheet({
    required this.bottomBarList,
    super.key,
  });

  final List<Widget> bottomBarList;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Padding(
        padding: EdgeInsets.only(left: 20.0.w, bottom: 20.h),
        child: Column(
          children: bottomBarList,
        ),
      ),
    ]);
  }
}
