import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:flutter/cupertino.dart';

import '../../model/model_book.dart';

class BookProvider extends ChangeNotifier {
  List<Book> book = [];
  bool isLoading = true;
  int pageNumber = 1;
  RequestRouter requestRouter = RequestRouter();

  getAllBook(RequestCallbacks requestCallbacks) {
    isLoading = true;
    final queryParams = {'page': pageNumber};
    requestRouter.getBooks(
        queryParams,
        RequestCallbacks(onSuccess: (data) {
          pageNumber++;
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
