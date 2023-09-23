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

  getProfile(RequestCallbacks requestCallbacks) {
    _networkRequest.getCall("user-profile", null, requestCallbacks);
  }

  getMyBooks(RequestCallbacks requestCallbacks) {
    _networkRequest.getCall("my-books", null, requestCallbacks);
  }

  getBooks(Map<String, dynamic>? queryParams,RequestCallbacks requestCallbacks) {
    _networkRequest.getCall("books", null, requestCallbacks);
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
