import 'dart:convert';

import 'package:bookshare/widget/components/loader.dart';
import 'package:bookshare/widget/components/not_found.dart';
import 'package:bookshare/widget/components/shimmer_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/colors.dart';
import '../../../../../widget/essentials/button.dart';
import '../../../../../widget/tag/general_tag.dart';
import '../../../../network/callback.dart';
import '../../../../network/request_route.dart';
import '../../../../widget/components/shimmer_general.dart';
import '../../../../widget/components/shimmer_loader.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _notFound = false;
  bool _loading = false;
  int page = 1;
  String q = "";
  RequestRouter requestRouter = RequestRouter();
  List newArrBook = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadBooks();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!_loading) {
        page++;
        loadBooks();
      }
    }
  }

  void loadBooks() {
    setState(() {
      _loading = true;
    });
    requestRouter.get(
        'books-for-rent',
        {"per_page": '100', "page": '$page', "q": q},
        RequestCallbacks(onSuccess: (response) {
          Map<String, dynamic> jsonMap = json.decode(response);
          setState(() {
            newArrBook.addAll(jsonMap['books']['data']);
            _notFound = newArrBook.isEmpty;
            _loading = false;
          });
        }, onError: (error) {
          setState(() {
            //_notFound = true;
            _loading = false;
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            color: yellowPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Search', style: header.copyWith(color: blackPrimary)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 0, left: 15, right: 15),
            child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    q = value;
                  });

                  if (value.length > 4 || value.isEmpty) {
                    page = 1;
                    loadBooks();
                  }
                },
                keyboardType: TextInputType.name,
                decoration: inputDecoration.copyWith(
                    label: const Text('Search...'),
                    hintText: "Please search above 4 character",
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.search_rounded),
                      onTap: () => {loadBooks()},
                    ))),
          ),
          _notFound
              ? Center(child: SizedBox(height: 30.h, child: const NotFound(text: "We are sorry\nwe couldn't find the book which you searched")))
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: newArrBook.length + 1,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < newArrBook.length) {
                          Map<String, dynamic> images = json.decode(newArrBook[index]['images'] ?? '{"smallThumbnail": ""}');
                          return Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
                            child: Container(
                              decoration: generalBoxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                      height: 25.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(14.0),
                                        child: Image.network(
                                          images['smallThumbnail'].toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            // Return a default image widget when the network image fails to load
                                            return Image.asset(
                                                'assets/icons/book-stack.png', // Replace with the path to your default image asset
                                                fit: BoxFit.contain
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            newArrBook[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: heading1,
                                          ),
                                          Text(
                                            "by ${newArrBook[index]['author']}",
                                            style: heading1Bold,
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Tag(text: "68"),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Text("times rented", style: infoText, textAlign: TextAlign.center),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),

                                          Button(
                                              width: 100,
                                              text: "Rent",
                                              backgroundColor: yellowPrimary,
                                              onClick: () => {GoRouter.of(context).push("/book-details", extra: newArrBook[index])})
                                          // SizedBox(
                                          //   width: 100.w,
                                          //
                                          //   child: FilledButton(
                                          //     style: ButtonStyle(
                                          //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
                                          //     ),
                                          //     onPressed: () {
                                          //       GoRouter.of(context).push("/book-details");
                                          //     },
                                          //     child: const Text(
                                          //       "Rent",
                                          //       style: buttonText,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return _loading
                              ? const Padding(padding: EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15), child: ShimmerLoader())
                              : Container();
                        }
                      }))
        ],
      ),
    );
  }
}
