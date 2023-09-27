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


class NewArrivalScreen extends StatefulWidget {
  const NewArrivalScreen({super.key});

  @override
  NewArrivalState createState() => NewArrivalState();
}

class NewArrivalState extends State<NewArrivalScreen> {
   RequestRouter requestRouter = RequestRouter();
   List newArrBook = [];
   String q = "";
   @override
  void initState() {
    super.initState();
    loadNewArrivals();
  }
    void loadNewArrivals() {
    requestRouter.get(
        'books-for-rent',
        {"per_page": '25', "q" : q.toString()},
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              print(jsonMap['books']['data']);
              setState(() {
                 newArrBook = jsonMap['books']['data'];
              });
            },
            onError: (error) {}));
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
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: newArrBook.length,
                  itemBuilder: (context, index) {
                     Map<String, dynamic> images =
                              json.decode(newArrBook[index]['images']);
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
