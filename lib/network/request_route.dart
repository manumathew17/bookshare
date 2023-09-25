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
    _networkRequest.postCall(url, requestBody, requestCallbacks);
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
  getProfile(RequestCallbacks requestCallbacks) {
    _networkRequest.getCall("user-profile", null, requestCallbacks);
  }

  getMyBooks(RequestCallbacks requestCallbacks) {
    _networkRequest.getCall("my-books", null, requestCallbacks);
  }

  getBooks(String url, Map<String, dynamic>? queryParams,RequestCallbacks requestCallbacks) {
    _networkRequest.getCall(url, queryParams, requestCallbacks);
  }

  addBookForRent(dynamic requestBody, RequestCallbacks requestCallbacks) {
    _networkRequest.postCall('book-for-rent', requestBody, requestCallbacks);
  }
  
  updateProfile(dynamic requestBody, RequestCallbacks requestCallbacks){
    _networkRequest.postCall('update-profile', requestBody, requestCallbacks);
  }

  uploadImage(String filePath, RequestCallbacks requestCallbacks) {
    _networkRequest.uploadImage(filePath, requestCallbacks);
  }
}
