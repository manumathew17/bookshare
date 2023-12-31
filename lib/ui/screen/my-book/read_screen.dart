import 'dart:convert';

import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/ui/screen/success/success-screen.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookshare/helpers/helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../theme/colors.dart';
import '../../../widget/components/not_found.dart';
import '../../../widget/components/shimmer_general.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  ReadScreenState createState() => ReadScreenState();
}

class ReadScreenState extends State<ReadScreen> {
  List booksOnRent = [];
  bool _notFound = false;
  bool _loading = false;
  late Razorpay _razorpay;
  dynamic order;
  RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  @override
  void initState() {
    super.initState();
    loadBookOnRent();
    _generalSnackBar = GeneralSnackBar(context);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadBookOnRent() {
    setState(() {
      _loading = true;
    });
    requestRouter.get(
        'books-on-rent',
        {"renter": ''},
        RequestCallbacks(onSuccess: (response) {
          Map<dynamic, dynamic> jsonMap = json.decode(response);
          List booksOnRentTemp = [];
          jsonMap['books'].forEach((item) {
            item['images'] = json.decode(item['images'] ?? '{"smallThumbnail": ""}');
            booksOnRentTemp.add(item);
          });
          setState(() {
            _loading = false;
            booksOnRent = booksOnRentTemp;
            _notFound = booksOnRent.isEmpty;
          });
        }, onError: (error) {
          setState(() {
            _loading = false;
          });
        }));
  }

  double getRemaningValue(books) {
    DateTime startDate = DateTime.parse(books['rent_start_date']);
    DateTime endDate = DateTime.parse(books['rent_end_date']);
    DateTime now = DateTime.now();
    Duration diff1 = endDate.difference(startDate);
    Duration diff2 = endDate.difference(now);
    if (diff1.inDays - diff2.inDays > 0) {
      return (diff1.inDays - diff2.inDays) / diff1.inDays;
    }
    return 0;
  }

  String getReturnDate(books) {
    DateTime inputDate = DateFormat("yyyy-MM-dd").parse(books['rent_end_date']);
    return DateFormat("d'th' MMMM yyyy").format(inputDate);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "SUCCESS: ${response.paymentId}", toastLength: Toast.LENGTH_SHORT);
    requestRouter.post(
        'penalty-payment-success',
        {"payment_id": order['payment']['id'].toString(), "payment_responce": response.toString(), "transaction_id": response.paymentId.toString()},
        RequestCallbacks(
            onSuccess: (response) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SuccessScreen()),
              );
              loadBookOnRent();
            },
            onError: (error) {}));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: ${response.code} - ${response.message}", toastLength: Toast.LENGTH_SHORT);
    requestRouter.post(
        'penalty-payment-failed',
        {
          "payment_id": order['payment']['id'].toString(),
        },
        RequestCallbacks(onSuccess: (response) {}, onError: (error) {}));
  }

  void openCheckout(dynamic bookForRent, double amount) {
    if (amount <= 0) {
      return;
    }
    requestRouter.post(
        'pay-penalty',
        {
          'book_on_rent_id': bookForRent['id'],
        },
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              setState(() {
                order = jsonMap;
              });
              //TODO api call is curroct or not for non due return
              if (order['payment'] == false) {
                _generalSnackBar.showSuccessSnackBar("Book Returned Successfully");
                loadBookOnRent();
                return;
              }
              var options = {
                "key": "rzp_test_wYGTVVN9s3z8GV",
                "amount": double.parse(order['payment']['amount'].toString()) * 100,
                "name": "LicExamGuru",
                "description": "Purches credit for mandi app",
                "prefill": {"contact": "7506163660", "email": "rajnimt16@gmail.com"},
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
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: ${response.walletName}", toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_loading)
          const Expanded(child: GeneralShimmer())
        else
          _notFound
              ? Center(child: SizedBox(height: 30.h, child: const NotFound(text: "No data found")))
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: booksOnRent.length,
                      itemBuilder: (context, index) {
                        double totalAmount = double.parse(booksOnRent[index]['total_amount'].toString());
                        double paidAmount = double.parse(booksOnRent[index]['paid_amount'].toString());
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(14.0),
                                      child: Image.network(
                                        booksOnRent[index]['images']['smallThumbnail'].toString(),
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
                                          booksOnRent[index]['title'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: heading1Bold,
                                        ),
                                        Text(
                                          "by ${booksOnRent[index]['author']}",
                                          style: heading1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: 1,
                                              width: 100.w,
                                              decoration: const BoxDecoration(
                                                color: Color(0xffdadada),
                                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                              )),
                                        ),
                                        Text("Rented from Mr. ${booksOnRent[index]['name']}",
                                            style: const TextStyle(
                                                color: Color(0xff000000), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0),
                                            textAlign: TextAlign.left),
                                         Text("Overdue by ${Helper.showDateNo(booksOnRent[index])} days",
                                            style: const TextStyle(
                                                color: Color(0xffe51a1a), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0),
                                            textAlign: TextAlign.center),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        LinearProgressIndicator(
                                          backgroundColor: Colors.grey,
                                          value: getRemaningValue(booksOnRent[index]),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        totalAmount - paidAmount > 0
                                            ? Button(
                                                width: 100,
                                                text: "Return with ${totalAmount - paidAmount} penalty",
                                                backgroundColor: yellowPrimary,
                                                onClick: () => {openCheckout(booksOnRent[index], totalAmount - paidAmount)})
                                            : Button(
                                            width: 100,
                                            text: "Return",
                                            backgroundColor: yellowPrimary,
                                            onClick: () => {openCheckout(booksOnRent[index], 0)})
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
                      }))
      ],
    ));
  }
}
