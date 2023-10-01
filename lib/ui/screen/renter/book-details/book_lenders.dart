import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/essentials/button.dart';
import '../../../../widget/tag/general_tag.dart';
import '../../success/success-screen.dart';

class BookLenders extends StatefulWidget {
  const BookLenders({super.key, this.bookId, this.endDate});
  final int? bookId ;
  final String? endDate;
  @override
  BookLendersState createState() => BookLendersState();
}

class BookLendersState extends State<BookLenders> {
   RequestRouter requestRouter = RequestRouter();
  List bookWonners = [];
  late Razorpay _razorpay;
  dynamic selectedBook;
  dynamic order;
  @override
  void initState() {
    super.initState();
    loadBookWonners();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS: ${response.paymentId}", toastLength: Toast.LENGTH_SHORT);
    requestRouter.post(
        'rent-payment-success',
        {
          "payment_id": order['payment']['id'].toString(),
          "book_for_rent_id":  order['payment']['book_for_rent_id'].toString(),
          "book_on_rent_id":  order['payment']['book_on_rent_id'].toString(),
          "payment_responce": response.toString(),
          "transaction_id": response.paymentId.toString()
        },
        RequestCallbacks(
            onSuccess: (response) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SuccessScreen()),
              );
            },
            onError: (error) {}));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: ${response.code} - ${response.message}",
        toastLength: Toast.LENGTH_SHORT);
         requestRouter.post(
        'rent-payment-failed',
        {
          "payment_id": order['payment']['id'].toString(),
          "book_for_rent_id":  order['payment']['book_for_rent_id'].toString(),
          "book_on_rent_id":  order['payment']['book_on_rent_id'].toString(),
          "payment_responce": "Payment failed"
        },
        RequestCallbacks(
            onSuccess: (response) {
            },
            onError: (error) {}));
  }

  void openCheckout(dynamic book) {

    DateTime now = DateTime.now();
    String startDate = DateFormat('yyyy-MM-dd').format(now);
    requestRouter.post(
        'get-book-on-rent',
        {
          'book_id': widget.bookId,
          'book_for_rent_id': book['book_for_rent_id'],
          'rent_start_date': startDate.toString(),
          'rent_end_date': widget.endDate.toString()
        },
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                order = jsonMap;
                selectedBook = book;
              });
              var options = {
                "key": "rzp_test_wYGTVVN9s3z8GV",
                "amount": double.parse(order['payment']['amount'].toString()) * 100,
                "name": "LicExamGuru",
                "description": "Purches credit for mandi app",
                "prefill": {
                  "contact": "7506163660",
                  "email": "rajnimt16@gmail.com"
                },
                'external': {
                  'wallets': ['paytm']
                },
              };
              try {
                _razorpay.open(options);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            onError: (error) {}));
  }

  Future<void> _handleExternalWallet(ExternalWalletResponse response) async {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: ${response.walletName}",
        toastLength: Toast.LENGTH_SHORT);
  }
  void loadBookWonners() {
    requestRouter.get(
        'book-owners',
        {"book_id": widget.bookId.toString(),"rent_end_date": widget.endDate.toString() },
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                bookWonners = jsonMap['woners'];
              });
            },
            onError: (error) {}));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.grey,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.cancel),
                  color: textGrey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          const Text("Available Lessors of this book", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          ListView.builder(
              shrinkWrap: true,
              itemCount: bookWonners.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 25.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            requestRouter.url(bookWonners[index]['profile_image']),
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
                              "Mr. ${bookWonners[index]['name']}",
                              style: heading1Bold,
                            ),
                            Text(
                              " ${bookWonners[index]['rent_cost_per_day']} / day",
                              style: heading1Bold,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text("4.98 (121 rental on this book", style: infoText, textAlign: TextAlign.center),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),

                            Button(
                                width: 100,
                                text: "Pay ${bookWonners[index]['rent_cost']} to Rent",
                                backgroundColor: yellowPrimary,
                                onClick: () {
                                  openCheckout(bookWonners[index]);
                                })
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
                );
              }),
        ],
      ),
    );
  }
}
