import 'package:flutter/material.dart';
import 'package:flutter_tiktok_clone/controllers/search_controller.dart';
import 'package:flutter_tiktok_clone/models/user.dart';
import 'package:flutter_tiktok_clone/views/screens/profile_screen.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MySearchController searchController = Get.put(
    MySearchController(),
  );
  final TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    searchController.searchedUsers.clear();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: TextField(
            controller: textEditingController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  if (textEditingController.text.isNotEmpty) {
                    textEditingController.clear();
                    setState(() {
                      searchController.searchedUsers.clear();
                    });
                  }
                },
                child: const Icon(
                  Icons.clear_rounded,
                  size: 30,
                ),
              ),
              fillColor: Colors.grey.withOpacity(0.3),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });
                await searchController.searchUsers(value);
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : searchController.searchedUsers.isEmpty
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(user.profilePhoto),
                            ),
                            title: Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
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
