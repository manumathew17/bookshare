import 'dart:convert';

import 'package:bookshare/model/model_user.dart';
import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/account.dart';
import '../../config/const.dart';

class AuthProvider extends ChangeNotifier {
  bool authExpired = false;
  RequestRouter requestRouter = RequestRouter();
  UserDetail userDetail = AccountConfig.userDetail;

  Map<String, String?> fieldErrors = {
    'name': null,
    'email': null,
    'password': null,
    'mobile': null,
  };

  createAccount(Map<String, dynamic> requestBody, RequestCallbacks requestCallbacks) {
    fieldErrors.forEach((key, _) {
      fieldErrors[key] = null;
    });
    requestRouter.register(
        requestBody,
        RequestCallbacks(onSuccess: (response) {
          Map<String, dynamic> jsonMap = json.decode(response);
          AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
          storeDetails(AccountConfig.userDetail);
          userDetail = AccountConfig.userDetail;
          notifyListeners();
          requestCallbacks.onSuccess(response);
        }, onError: (error) {
          Map<String, dynamic> responseMap = jsonDecode(jsonDecode(error));
          try {
            responseMap.forEach((key, value) {
              if (fieldErrors.containsKey(key)) {
                var errorMessage = value is List ? value.join('\n') : value.toString();
                fieldErrors[key] = errorMessage;
              }
            });
          } catch (e) {
            print(e.toString());
          }

          notifyListeners();
        }));
  }

  getUserProfile() {
    requestRouter.getProfile(RequestCallbacks(
        onSuccess: (response) {
          Map<String, dynamic> jsonMap = jsonDecode(response);
          AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
          //storeDetails(AccountConfig.userDetail);
          userDetail = AccountConfig.userDetail;
          //AccountConfig.JWT_TOKEN = AccountConfig.userDetail.accessToken;
          notifyListeners();
        },
        onError: (error) {}));
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(SharedPrefKeys.login.name);
    Logger.log(userString);
    if (userString != null) {
      final Map<String, dynamic> jsonMap = json.decode(userString);

      AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
      userDetail = AccountConfig.userDetail;
      notifyListeners();
      if (AccountConfig.userDetail.accessToken == "") {
        return false;
      } else {
        AccountConfig.JWT_TOKEN = AccountConfig.userDetail.accessToken;
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> storeDetails(UserDetail userDetail) async {
    AccountConfig.JWT_TOKEN = userDetail.accessToken;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonMap = userDetail.toJson();
    final jsonString = jsonEncode(jsonMap);
    return await prefs.setString(SharedPrefKeys.login.name, jsonString);
  }

  Future<bool> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }
}
