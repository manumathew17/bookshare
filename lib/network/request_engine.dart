import 'dart:convert';

import 'package:bookshare/config/account.dart';
import 'package:http/http.dart' as http;
import '../config/const.dart';
import '../navigation/app_route.dart';
import '../utils/Logger.dart';
import '../widget/components/loader.dart';
import '../widget/components/snackbar.dart';
import 'callback.dart';

class NetworkRequest {
  final GeneralSnackBar _generalSnackBar = GeneralSnackBar(navigatorKey.currentContext!);
  final List<int> successStatusCodes = [200, 201];

  static Map<String, String> getHeaders() {
    return {'Authorization': 'Bearer ${AccountConfig.JWT_TOKEN}', 'Content-Type': 'application/json'};
  }

  Future<void> getCall(String route, Map<String, dynamic>? queryParams, RequestCallbacks requestCallbacks) async {
    Logger.log(Uri.parse(API_ENDPOINT + route).replace(queryParameters: queryParams));
    try {
      final response = await http.get(Uri.parse(API_ENDPOINT + route).replace(queryParameters: queryParams), headers: getHeaders());

      if (successStatusCodes.contains(response.statusCode)) {
        final responseData = response.body;
        Logger.log(responseData);
        requestCallbacks.onSuccess(responseData.toString());
      } else {
       // _showError(response.body);
        requestCallbacks.onError(response.body);
      }
      Loader.hide();
    } catch (e) {
      _showInternetError();
      requestCallbacks.onError(e.toString());
      Loader.hide();
    }
  }

  Future<void> postCall(String route, dynamic requestBody, RequestCallbacks requestCallbacks) async {
    Logger.log("url $API_ENDPOINT$route\n $requestBody");
    try {
      final response = await http.post(
        Uri.parse(API_ENDPOINT + route),
        headers: getHeaders(),
        body: json.encode(requestBody),
      );

      if (successStatusCodes.contains(response.statusCode)) {
        final responseData = response.body;
        Logger.log(responseData);
        Loader.hide();
        requestCallbacks.onSuccess(responseData);
      } else {
        Loader.hide();
        print(response.body);
       // _showError(response.body);
        requestCallbacks.onError(response.body);
      }
    } catch (e) {
      print(e.toString());
      Loader.hide();
      _showInternetError();
      requestCallbacks.onError(e.toString());
    }
  }

  Future<void> putCall(String route, dynamic requestBody, RequestCallbacks requestCallbacks) async {
    Logger.log("url $API_ENDPOINT$route\n ${jsonEncode(requestBody)}");
    Logger.log("JWT ${AccountConfig.JWT_TOKEN}");
    try {
      final response = await http.put(
        // Use http.put instead of http.post
        Uri.parse(API_ENDPOINT + route),
        headers: getHeaders(),
        body: jsonEncode(requestBody),
      );

      if (successStatusCodes.contains(response.statusCode)) {
        final responseData = response.body;
        Logger.log(responseData);
        requestCallbacks.onSuccess(responseData);
      } else {
       // _showError(response.body);
        requestCallbacks.onError(response.body);
      }
    } catch (e) {
      _showInternetError();
      requestCallbacks.onError(e.toString());
    }
  }

  noAuthPost(String route, dynamic requestBody, RequestCallbacks requestCallbacks) async {
    Logger.log("url $API_ENDPOINT$route\n $requestBody");

    try {
      final response =
          await http.post(Uri.parse(API_ENDPOINT + route), body: json.encode(requestBody), headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      if (successStatusCodes.contains(response.statusCode)) {
        final responseData = response.body;
        print(responseData);
        requestCallbacks.onSuccess(responseData);
      } else {
        print(response.body);
        //_showError(response.body);
        requestCallbacks.onError(jsonDecode(response.body));
      }
      Loader.hide();
    } catch (e) {
      print(e.toString());
      _showInternetError();
      Loader.hide();
    }
  }

  _showError(error) {
    Map<String, dynamic> jsonDataMap = jsonDecode(error);
    _generalSnackBar.showErrorSnackBar(jsonDataMap['error']);
  }

  _showInternetError() {
    _generalSnackBar.showErrorSnackBar("Something went wrong, internet not available");
  }
}
