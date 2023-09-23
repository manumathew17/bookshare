import 'package:bookshare/widget/components/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AddBookHome(
      onClick: () => {widget.onTabSwitch()},
    )

        // ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: 10,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.only(top: 0, bottom: 20, left: 15, right: 15),
        //         child: Container(
        //           decoration: generalBoxDecoration,
        //           child: Padding(
        //             padding: const EdgeInsets.all(12.0),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 SizedBox(
        //                   width: 20.w,
        //                   height: 25.w,
        //                   child: ClipRRect(
        //                     borderRadius: BorderRadius.circular(14.0),
        //                     child: Image.network(
        //                       'https://images1.penguinrandomhouse.com/cover/9780593500507',
        //                       fit: BoxFit.cover,
        //                       loadingBuilder: (BuildContext context, Widget child,
        //                           ImageChunkEvent? loadingProgress) {
        //                         if (loadingProgress == null) {
        //                           return child;
        //                         } else {
        //                           return  Center(
        //                               child: ShimmerContainer(width: 20.w, height: 25.w)
        //                           );
        //                         }
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 5.w,
        //                 ),
        //                 Expanded(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Text(
        //                         "Follow me to ground",
        //                         overflow: TextOverflow.ellipsis,
        //                         maxLines: 1,
        //                         style: heading1Bold,
        //                       ),
        //                       Text(
        //                         "by sure Rainford",
        //                         style: heading1,
        //                       ),
        //                       SizedBox(
        //                         height: 2.h,
        //                       ),
        //
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         children: [
        //                           Tag(text: "68"),
        //                           SizedBox(
        //                             width: 1.w,
        //                           ),
        //                           Text("times rented", style: infoText, textAlign: TextAlign.center),
        //                         ],
        //                       ),
        //
        //                       SizedBox(
        //                         height: 1.h,
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         children: [
        //                           Tag(text: "500"),
        //                           SizedBox(
        //                             width: 2.w,
        //                           ),
        //                           Text("Payout Generated", style: infoText, textAlign: TextAlign.center),
        //                         ],
        //                       ),
        //
        //                       // SizedBox(
        //                       //   width: 100.w,
        //                       //   child: FilledButton(
        //                       //     style: ButtonStyle(
        //                       //       backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the background color here
        //                       //     ),
        //                       //     onPressed: () {
        //                       //       GoRouter.of(context).push("/book-details");
        //                       //     },
        //                       //     child: const Text(
        //                       //       "Return with 200 penalty",
        //                       //       style: buttonText,
        //                       //     ),
        //                       //   ),
        //                       // )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       );
        //     })

        );
  }
}
