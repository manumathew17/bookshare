import 'package:bookshare/widget/components/not_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/colors.dart';
import '../../../../../widget/essentials/button.dart';
import '../../../../../widget/tag/general_tag.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  bool _notFound = false;

  serach() {
    setState(() {
      _notFound = true;
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
        title: Text('Search', style: header.copyWith(color: blackPrimary)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 0, left: 15, right: 15),
            child: TextFormField(
                keyboardType: TextInputType.name,
                decoration: inputDecoration.copyWith(
                    label: const Text('Search...'),
                    suffixIcon: GestureDetector(
                      child: const Icon(Icons.search_rounded),
                      onTap: () => {serach()},
                    ))),
          ),
          _notFound
              ?  Center(child: SizedBox(
            height: 30.h,
              child: const NotFound(text: "We are sorry\nwe couldn't find the book which you searched")))
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
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
                                        'https://images1.penguinrandomhouse.com/cover/9780593500507',
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
                                          "Follow me to ground",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: heading1,
                                        ),
                                        Text(
                                          "by sure Rainford",
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
