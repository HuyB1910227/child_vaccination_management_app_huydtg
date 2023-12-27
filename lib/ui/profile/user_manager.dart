import 'package:flutter/foundation.dart';
import '../../services/user/user_service.dart';
import '../../models/user/user.dart';
import '../../models/auth_token.dart';
class UserManager with ChangeNotifier {


  final UserService _userService;

  UserManager([AuthToken? authToken])
      : _userService = UserService(authToken);

  set authToken(AuthToken? authToken) {
    _userService.authToken = authToken;
  }

  Future<User?> fetchUserDetail() async {
    return await _userService.fetchCustomerByToken();
  }


  Future<bool> isInvalidUsername(String username) async {
    try {
      return await _userService.isInvalidValue(null, username);
    } catch (e) {
      return false;
    }
  }

  Future<User?> updateUsername(String username) async {
    try {
      return await _userService.updateUsername(username);
    } catch (e) {
      return null;
    }
  }

  Future<User?> updatePassword(String oldPassword, String newPassword) async {
    print("running");
    try {
      return await _userService.updatePassword(oldPassword, newPassword);
    } catch (e) {
      return null;
    }
  }


}