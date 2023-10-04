import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/controllers/comment_controller.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});
  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());
  final myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Obx(
                () {
                  return SizedBox(
                    height: size.height * 0.75,
                    child: ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.username,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                comment.comment,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                timeago.format(comment.datePublished.toDate()),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                comment.likes.length.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () => commentController.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              color: comment.likes.contains(authController.user.uid) ? Colors.red : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                title: Form(
                  key: myKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter something';
                      }
                      return null;
                    },
                    controller: _commentController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                        hintText: 'comment',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                        filled: true),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    final isValid = myKey.currentState!.validate();
                    if (isValid) {
                      commentController.postComment(_commentController.text);
                    }
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
