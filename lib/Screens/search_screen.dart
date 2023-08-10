import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frendify/Screens/myprofile_screen.dart';
import 'package:frendify/constants.dart';

import '../Authentication/auth.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  List<Map<String, dynamic>> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          // Add padding around the search bar
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          // Use a Material design search bar
          child: TextField(
            onChanged: (val) {
              setState(() {
                searchText = val;
              });
            },
            cursorColor: Colors.black,
            decoration: kTextFieldDecoration.copyWith(
              fillColor: const Color(0xffF5F5F5),
              hintStyle: kText3.copyWith(
                  fontSize: 15.sp,
                  color: const Color(0xffbdbdbd),
                  fontWeight: FontWeight.w400),
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search_sharp,
                color: primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Auth().db.collection('users').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;
                    if (searchText.isEmpty) {
                      return Container();
                    }
                    if (data['name']
                        .toString()
                        .startsWith(searchText.toLowerCase())) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyProfileScreen(userId: data['userid']),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(
                            data['username'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kText2.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kText2,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              data['pfp'],
                            ),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
