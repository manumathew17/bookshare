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

  get(String url, dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.getCall(url, requestBody, requestCallbacks);
  }

  post(String url, dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.noAuthPost(url, requestBody, requestCallbacks);
  }

  put(String url, dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.noAuthPost(url, requestBody, requestCallbacks);
  }

  delete(String url, dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.noAuthPost(url, requestBody, requestCallbacks);
  }

  url(String url) {
    return _networkRequest.url(url);
  }
}
