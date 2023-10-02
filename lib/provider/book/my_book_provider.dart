import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../model/model_book.dart';
import '../../network/callback.dart';
import '../../network/request_route.dart';

class MyBookProvider extends ChangeNotifier {
  List<Book> book = [];
  bool isLoading = true;
  int pageNumber = 1;
  dynamic queryParams = {"page": 1, "per_page": 20, "q": "", "mybook": false};
  RequestRouter requestRouter = RequestRouter();

  getAllBook(String url, RequestCallbacks requestCallbacks) {
    isLoading = true;
    notifyListeners();
    requestRouter.getBooks(
        url,
        {
          "page": queryParams['page'].toString(),
          "per_page": queryParams['per_page'].toString(),
          "q": queryParams['q'],
          "mybook": queryParams['mybook'].toString()
        },
        RequestCallbacks(onSuccess: (responce) {
          Map<String, dynamic> data = json.decode(responce);
          queryParams['page']++;
          isLoading = false;
          _createBookArrayList(data);
          notifyListeners();
          requestCallbacks.onSuccess("success");
        }, onError: (error) {
          isLoading = false;
          notifyListeners();
          requestCallbacks.onError(error);
        }));
  }

  _createBookArrayList(data) {
    List<dynamic> list = data['books']['data'];
    book.addAll(list.map((item) => Book.fromJson(item)).toList());
    notifyListeners();
  }
}