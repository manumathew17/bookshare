import 'dart:convert';

import 'package:bookshare/model/model_user.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/account.dart';
import '../../config/const.dart';

class AuthProvider extends ChangeNotifier {

  bool authExpired = false;

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(SharedPrefKeys.login.name);
    if (userString != null) {
      final Map<String, dynamic> jsonMap = json.decode(userString);

      AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
      if (AccountConfig.userDetail.accessToken == "") {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> storeDetails(UserDetail userDetail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonMap = userDetail.toJson();
    final jsonString = jsonEncode(jsonMap);
    Logger.log(jsonString);
    return await prefs.setString(SharedPrefKeys.login.name, jsonString);
  }


}
