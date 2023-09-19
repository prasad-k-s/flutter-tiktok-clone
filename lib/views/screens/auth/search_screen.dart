import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/controllers/search_controller.dart';
import 'package:flutter_tiktok_clone/models/user.dart';
import 'package:flutter_tiktok_clone/views/screens/profile_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final MySearchController searchController = Get.put(
    MySearchController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextFormField(
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                searchController.searchUsers(value);
              }
            },
          ),
        ),
        body: searchController.searchedUsers.isEmpty
            ? const Center(
                child: Text(
                  'Search for users',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: searchController.searchedUsers.length,
                itemBuilder: (context, index) {
                  User user = searchController.searchedUsers[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProfileScreen(uid: user.uid);
                        },
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePhoto),
                      ),
                      title: Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
