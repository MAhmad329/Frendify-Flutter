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

  Future<List<Map<String, dynamic>>> _searchUsers() async {
    if (searchText.isEmpty) {
      return []; // Return an empty list if search text is empty
    }

    final QuerySnapshot snapshot = await Auth().db.collection('users').get();
    final List<Map<String, dynamic>> users = [];

    for (var doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (data['name'].toString().startsWith(searchText.toLowerCase())) {
        users.add(data);
      }
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _searchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (searchText.isNotEmpty &&
              (!snapshot.hasData || snapshot.data!.isEmpty)) {
            return const Center(
              child: Text('No matching users found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
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
                      data['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kText2,
                    ),
                    subtitle: Text(
                      data['email'],
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
              },
            );
          }
        },
      ),
    );
  }
}
