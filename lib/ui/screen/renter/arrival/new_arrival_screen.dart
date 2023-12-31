import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:bookshare/widget/tag/general_tag.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../utils/Logger.dart';
import '../../../../widget/components/not_found.dart';
import '../../../../widget/components/shimmer_general.dart';

class NewArrivalScreen extends StatefulWidget {
  const NewArrivalScreen({super.key, this.category});
  final String? category;
  @override
  NewArrivalState createState() => NewArrivalState();
}

class NewArrivalState extends State<NewArrivalScreen> {
  RequestRouter requestRouter = RequestRouter();
  List parentList = [];
  List newArrBook = [];
  String q = "";
  bool _notFound = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.category!.isNotEmpty) {
      setState(() {
        q = widget.category!;
      });
    }
    loadNewArrivals();
  }

  void loadNewArrivals() {
    if(_loading) {
      return;
    }
    setState(() {
      _loading = true;
    });
    requestRouter.get(
        'books-for-rent',
        {"per_page": '25', "q": q.toString()},
        RequestCallbacks(onSuccess: (response) {
          Map<String, dynamic> jsonMap = json.decode(response);
          parentList = jsonMap['books']['data'];
          setState(() {
            newArrBook = jsonMap['books']['data'];
            _loading = false;
            _notFound = newArrBook.isEmpty;
          });
        }, onError: (error) {
          setState(() {
            _loading = false;
          });
        }));
  }

  void search() {
    setState(() {
      if (q.isEmpty) {
        newArrBook = parentList;
      } else {
        newArrBook = parentList
            .where((book) => book['title'].toLowerCase().contains(q.toLowerCase()) || book['author'].toLowerCase().contains(q.toLowerCase()))
            .toList();
      }

      _notFound = newArrBook.isEmpty;
    });
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
        title: Text('New arrival', style: header.copyWith(color: blackPrimary)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    q = value;
                  });

                  search();
                },
                keyboardType: TextInputType.name,
                decoration: inputDecoration.copyWith(
                    label: const Text('Search...'),
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.search_rounded),
                      onTap: () {
                        loadNewArrivals();
                      },
                    ))),
          ),
          _loading
              ? const Expanded(child: GeneralShimmer())
              : _notFound
                  ? Center(child: const NotFound(text: "We are sorry\nwe couldn't find the book which you searched"))
                  : Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: newArrBook.length,
                          itemBuilder: (context, index) {
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
                          }))
        ],
      ),
    );
  }
}
