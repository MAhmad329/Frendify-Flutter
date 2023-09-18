import 'package:flutter/material.dart';
import 'package:frendify/Models/comments_model.dart';
import 'package:frendify/Screens/myprofile_screen.dart';

class CommentListView extends StatelessWidget {
  final List<Comment> comments;

  const CommentListView({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyProfileScreen(userId: comment.authorId),
              ),
            );
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black,
              backgroundImage: comment.authorPicture.isNotEmpty
                  ? NetworkImage(comment.authorPicture)
                  : const NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg'),
            ),
            title: Text(comment.authorName),
            subtitle: Text(comment.comment),
          ),
        );
      },
    );
  }
}
