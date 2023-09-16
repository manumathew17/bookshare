import 'package:bookshare/network/request_engine.dart';

import 'callback.dart';

class RequestRouter {
  final NetworkRequest _networkRequest = NetworkRequest();

  void validateUser(dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.noAuthPost('login', requestBody, requestCallbacks);
  }

  register(dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.noAuthPost('register', requestBody, requestCallbacks);
  }
}
