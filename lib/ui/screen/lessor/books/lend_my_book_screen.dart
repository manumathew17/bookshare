import 'package:bookshare/network/callback.dart';
import 'package:bookshare/provider/book/book_provider.dart';
import 'package:bookshare/widget/components/no_data.dart';
import 'package:bookshare/widget/components/shimmer_general.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../widget/components/home_addBook.dart';
import '../../../../widget/components/shimmer_container.dart';
import '../../../../widget/tag/general_tag.dart';

class LendMyBookScreen extends StatefulWidget {
  const LendMyBookScreen({super.key, required this.onTabSwitch});

  final VoidCallback onTabSwitch;

  @override
  LendMyBookScreenState createState() => LendMyBookScreenState();
}

class LendMyBookScreenState extends State<LendMyBookScreen> {
  late GeneralSnackBar _generalSnackBar;
  final ScrollController _scrollController = ScrollController();
  late BookProvider _bookProvider;

  @override
  void initState() {
    _bookProvider = Provider.of<BookProvider>(context, listen: false);
    _generalSnackBar = GeneralSnackBar(context);
    _scrollController.addListener(_scrollListener);
    _bookProvider.queryParams['page'] = 1;
    _bookProvider.queryParams['q'] = "";
    _bookProvider.queryParams['mybook'] = true;
    _bookProvider.book.clear();
    _getBook();
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!_bookProvider.isLoading) {
        _getBook();
      }
    }
  }

  _getBook() {
    _bookProvider.getAllBook(
        'my-books',
        RequestCallbacks(
            onSuccess: (response) => {},
            onError: (onError) {
              _generalSnackBar.showErrorSnackBar(
                  "Something went wrong, Please check the internet");
            }));
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<BookProvider>(builder: (context, bookProvider, child) {
      return Scaffold(
          body:
          bookProvider.isLoading ? const GeneralShimmer() :
          bookProvider.book.isEmpty
              ? AddBookHome(onClick: () => {widget.onTabSwitch()})
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: bookProvider.book.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 15, right: 15),
                              child: Container(
                                decoration: generalBoxDecoration,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                        height: 25.w,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          child: Image.network(
                                            bookProvider.book[index].images
                                                .smallThumbnail,
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                    child: ShimmerContainer(
                                                        width: 20.w,
                                                        height: 25.w));
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              bookProvider.book[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: heading1Bold,
                                            ),
                                            Text(
                                              "by, ${bookProvider.book[index].author}",
                                              style: heading1,
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ));
    });
  }
}
