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


class NewArrivalScreen extends StatefulWidget {
  const NewArrivalScreen({super.key});

  @override
  NewArrivalState createState() => NewArrivalState();
}

class NewArrivalState extends State<NewArrivalScreen> {
   RequestRouter requestRouter = RequestRouter();
   List newArrBook = [];
   @override
  void initState() {
    super.initState();
    loadNewArrivals();
  }
    void loadNewArrivals() {
    requestRouter.get(
        'books-for-rent',
        {"per_page": '25'},
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                setState(() {
                  newArrBook = jsonMap['books']['data'];
                });
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
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: textWhiteGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      // controller: _searchController,
                      // onChanged: (value) {
                      //   Provider.of<CatalogProvider>(context,
                      //       listen: false)
                      //       .search(value);
                      // },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search ',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
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
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Tag(text: "68"),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text("times rented", style: infoText, textAlign: TextAlign.center),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),

                                    Button(
                                        width: 100,
                                        text: "Rent",
                                        backgroundColor: yellowPrimary,
                                        onClick: () => {GoRouter.of(context).push("/book-details")})
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
