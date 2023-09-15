import 'package:flutter_tiktok_clone/constants.dart';
import 'package:flutter_tiktok_clone/models/user.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchUsers.value;

  searchUsers(String typedUser) async {
    _searchUsers.bindStream(
      firestore.collection('users').where('name', isGreaterThanOrEqualTo: typedUser).snapshots().map(
        (query) {
          List<User> value = [];
          for (var elem in query.docs) {
            value.add(
              User.fromSnap(elem),
            );
          }
          return value;
        },
      ),
    );
  }
}
