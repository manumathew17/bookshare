import 'package:bookshare/model/model_book.dart';
import 'package:bookshare/network/callback.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../network/request_route.dart';
import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/components/loader.dart';

class AddBookForRent extends StatefulWidget {
  final Book book;
  final VoidCallback onUpdate;

  const AddBookForRent({
    super.key,
    required this.onUpdate,
    required this.book,
  });

  @override
  AddBookForRentState createState() => AddBookForRentState();
}

class AddBookForRentState extends State<AddBookForRent> {
  final TextEditingController rentPerDayController = TextEditingController();
  final TextEditingController lateFineController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _generalSnackBar = GeneralSnackBar(context);
  }

  _addBookForRent(String rentPerDay, String lateFine, String quantity) {
    final requestBody = {"book_id": widget.book.id, "rent_cost_per_day": rentPerDay, "late_fine": lateFine, "quantity": quantity};
    Loader.show(context);
    requestRouter.addBookForRent(
        requestBody,
        RequestCallbacks(onSuccess: (_) {
          widget.onUpdate();
          _generalSnackBar.showSuccessSnackBar("Book Added Successfully");
        }, onError: (_) {
          _generalSnackBar.showErrorSnackBar("Error happened");
        }));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add for rent', style: header20),
            Text(
              widget.book.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: heading1Bold,
            ),
            Text(
              "by, ${widget.book.author}",
              style: heading1,
            ),
            SizedBox(
              height: 2.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: rentPerDayController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Rent per day'),
                      hintText: 'eg 10',
                      hintStyle: header12.copyWith(color: textGrey),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      filled: true,
                      fillColor: textWhiteGrey,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter rent per day';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: lateFineController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Late fine per day'),
                      hintText: '10',
                      hintStyle: header12.copyWith(color: textGrey),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      filled: true,
                      fillColor: textWhiteGrey,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Late fine per day';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: const Text('Book count'),
                      hintText: '10',
                      hintStyle: header12.copyWith(color: textGrey),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(14))
                      ),
                      filled: true,
                      fillColor: textWhiteGrey,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Book count';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // To close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(lentThemePrimary), // Set the button background color to blue
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Change the border radius here
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _addBookForRent(rentPerDayController.text, lateFineController.text, quantityController.text);
                      //_updateCustomerDetails(nameController.text, mobileController.text);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            SizedBox(height: 3.w),
          ],
        ),
      ),
    );
  }


}
