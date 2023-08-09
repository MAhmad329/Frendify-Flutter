import 'package:flutter/material.dart';
import 'package:frendify/Models/comments_model.dart';

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
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(comment.authorPicture),
          ),
          title: Text(comment.authorName),
          subtitle: Text(comment.comment),
        );
      },
    );
  }
}
