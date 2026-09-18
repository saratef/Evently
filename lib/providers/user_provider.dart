import 'package:flutter/widgets.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;
  void updateUser(MyUser newUser){
    currentUser=newUser;
    notifyListeners();
  }

  void clearUser() {
    currentUser = null;
    notifyListeners();
  }
}