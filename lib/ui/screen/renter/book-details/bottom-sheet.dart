import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/app_style.dart';

import '../../success/success-screen.dart';

class MyBottomSheet extends StatefulWidget {
  final Function onUpdate;

  const MyBottomSheet({super.key, required this.onUpdate});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate;

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
          const Text("Select Return Date", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          Form( key: _formKey, child:Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Set the background color to grey
                  borderRadius: BorderRadius.circular(10.0), // Set the border radius
                ),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () {
                    _showDatePicker();
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding
                    labelText: 'Select Date',
                    suffixIcon: Icon(
                      Icons.calendar_month_rounded,
                      color: yellowPrimary,
                    ),
                    border: InputBorder.none, // Remove input border
                  ),

                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please select return data';
                    } else {
                      return null;
                    }
                  },
                ),
              )), ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: 100.w,
              text: "Proceed",
              onClick: () {
                if(_formKey.currentState!.validate()){
                  Navigator.of(context).pop();
                  widget.onUpdate(_dateController.text);
                }

              },
              backgroundColor: yellowPrimary,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate; //set output date to TextField value.
      });
    } else {
      print("Date is not selected");
    }
  }
}
