import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frendify/Authentication/auth.dart';
import 'package:frendify/Screens/myprofile_screen.dart';
import 'package:frendify/constants.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key, required this.follows}) : super(key: key);
  final List<dynamic> follows;

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List followerList = [];
  bool isLoading = true;
  Future<void> getFollowersData() async {
    for (String email in widget.follows) {
      QuerySnapshot querySnapshot = await Auth()
          .db
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        setState(() {
          followerList.add({
            'name': userData['name'],
            'username': userData['username'],
            'pfp': userData['pfp'],
            'userid': userData['userid'],
          });
        });
      }
    }
    setState(() {
      isLoading = false; // Data fetching is complete
    });
  }

  @override
  void initState() {
    super.initState();
    getFollowersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Followers'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ), // Show loading indicator
            )
          : ListView.builder(
              itemCount: followerList.length,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyProfileScreen(
                            userId: followerList[index]['userid']),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                        followerList[index]['pfp'],
                      ),
                    ),
                    title: Text(followerList[index]['name']),
                    subtitle: Text(followerList[index]['username']),
                  ),
                );
              },
            ),
    );
  }
}
