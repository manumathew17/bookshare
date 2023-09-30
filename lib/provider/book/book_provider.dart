import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:flutter/cupertino.dart';

import '../../model/model_book.dart';

class BookProvider extends ChangeNotifier {
  List<Book> book = [];
  bool isLoading = true;
  int pageNumber = 1;
  dynamic queryParams = {"page": 1, "per_page": 20, "q": "", "mybook": false};
  RequestRouter requestRouter = RequestRouter();

  getAllBook(String url, RequestCallbacks requestCallbacks) {
    isLoading = true;
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
          requestCallbacks.onSuccess("success");
        }, onError: (error) {
          isLoading = false;
          requestCallbacks.onError(error);
        }));
  }

  _createBookArrayList(data) {
    List<dynamic> list = data['books']['data'];
    book.addAll(list.map((item) => Book.fromJson(item)).toList());
    notifyListeners();
  }
}
