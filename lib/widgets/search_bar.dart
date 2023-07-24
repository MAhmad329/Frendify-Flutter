import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class CustomSearchbar extends StatelessWidget {
  const CustomSearchbar({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add padding around the search bar
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      // Use a Material design search bar
      child: TextField(
        controller: _searchController,
        cursorColor: Colors.black,
        decoration: kTextFieldDecoration.copyWith(
          fillColor: const Color(0xffF5F5F5),
          hintStyle: kText3.copyWith(
              fontSize: 15.sp,
              color: const Color(0xffbdbdbd),
              fontWeight: FontWeight.w400),
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search_sharp),
        ),
      ),
    );
  }
}
