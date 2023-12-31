import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/provider/book/book_provider.dart';
import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../widget/components/shimmer_container.dart';
import '../../../../widget/components/shimmer_general.dart';
import '../../../../widget/components/shimmer_loader.dart';
import '../../../../widget/components/shimmer_utils.dart';
import 'add_book_for_rent.dart';

class LendAddBookScreen extends StatefulWidget {
  final VoidCallback onTabSwitch;

  const LendAddBookScreen({super.key, required this.onTabSwitch});

  @override
  LendAddBookScreenState createState() => LendAddBookScreenState();
}

class LendAddBookScreenState extends State<LendAddBookScreen> {
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
    _bookProvider.queryParams['mybook'] = false;
    _bookProvider.book.clear();
    _getBook();
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (!_bookProvider.isLoading && (_bookProvider.queryParams['page'] == 1 || _bookProvider.queryParams['q'] == "")) {
        _getBook();
      }
    }
  }

  _getBook() {
    _bookProvider.getAllBook(
        'books',
        RequestCallbacks(
            onSuccess: (response) => {},
            onError: (onError) {
              _generalSnackBar.showErrorSnackBar("Something went wrong, Please check the internet");
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookProvider>(builder: (context, bookProvider, child) {
      return Scaffold(
          body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 0, left: 15, right: 15),
            child: TextFormField(
                onChanged: (value) {
                  _bookProvider.queryParams['q'] = value;
                  _bookProvider.queryParams['page'] = 1;
                  _bookProvider.book.clear();
                },
                keyboardType: TextInputType.name,
                decoration: inputDecoration.copyWith(
                    label: const Text('Search...'),
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.search_rounded),
                      onTap: () {
                        _bookProvider.book.clear();
                        _getBook();
                      },
                    ))),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: bookProvider.book.length + 3,
                itemBuilder: (context, index) {
                  if (index < bookProvider.book.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
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
                                    bookProvider.book[index].images.smallThumbnail,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      // Return a default image widget when the network image fails to load
                                      return Image.asset('assets/icons/book-stack.png', // Replace with the path to your default image asset
                                          fit: BoxFit.contain);
                                    },
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return Center(child: ShimmerContainer(width: 20.w, height: 25.w));
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                                    Button(
                                        width: 100,
                                        text: "Add Book",
                                        backgroundColor: lentThemePrimary,
                                        onClick: () => {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  useSafeArea: true,
                                                  builder: (BuildContext context) {
                                                    return Padding(
                                                      padding: MediaQuery.of(context).viewInsets,
                                                      child: AddBookForRent(
                                                        book: bookProvider.book[index],
                                                        onUpdate: () => {Navigator.pop(context), widget.onTabSwitch()},
                                                      ),
                                                    );
                                                  })
                                            })
                                    // SizedBox(
                                    //   width: 100.w,
                                    //   child: FilledButton(
                                    //     style: ButtonStyle(
                                    //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
                                    //     ),
                                    //     onPressed: () {
                                    //       GoRouter.of(context).push("/book-details");
                                    //     },
                                    //     child: const Text(
                                    //       "Return with 200 penalty",
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
                    return bookProvider.isLoading
                        ? const Padding(padding: EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15), child: ShimmerLoader())
                        : Container();
                  }
                }),
          ),
        ],
      ));
    });
  }
}
