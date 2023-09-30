import 'package:bookshare/ui/screen/success/return_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../theme/app_style.dart';
import '../../../../../theme/colors.dart';
import '../../../../../widget/essentials/button.dart';
import '../../../success/success-screen.dart';

class WaiveOffBottomSheet extends StatefulWidget {
  const WaiveOffBottomSheet({super.key, required this.totalFine, required this.onProcess});
  final double totalFine;
  final Function? onProcess;
  @override
  _WaiveOffBottomSheetState createState() => _WaiveOffBottomSheetState();
}

class _WaiveOffBottomSheetState extends State<WaiveOffBottomSheet> {
  final TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String amount = "";
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
        mainAxisAlignment: MainAxisAlignment.center,
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
          const Text("How much do you want to waive off ?", style: header12, textAlign: TextAlign.center),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: 100.w,
              text: "Provide full waive off 45",
              onClick: () {
                Navigator.of(context).pop();
                widget.onProcess!(widget.totalFine);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const ReturnSuccessScreen(text: "Return Has been accepted")),
                // )
              },
              backgroundColor: greenButton,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("OR", style: header12, textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Enter amount manually'),
                  hintText: '10',
                  hintStyle: header12.copyWith(color: textGrey),
                  border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(14))),
                  filled: true,
                  fillColor: textWhiteGrey,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Enter amount';
                  }
                  return null;
                },
              ),
            ),
          ),
          // Padding(
          //     padding: const EdgeInsets.all(20),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.grey[200], // Set the background color to grey
          //         borderRadius: BorderRadius.circular(10.0), // Set the border radius
          //       ),
          //       child: TextFormField(
          //         controller: _dateController,
          //         decoration: const InputDecoration(
          //           contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding
          //           labelText: 'Enter amount manually',
          //           border: InputBorder.none, // Remove input border
          //         ),
          //       ),
          //     )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Button(
              width: 100.w,
              text: "Proceed",
              onClick: () {
                Navigator.of(context).pop();
                widget.onProcess!(double.parse(amountController.text));
                // if (_formKey.currentState!.validate())
                //   {
                //     Navigator.of(context).pop();
                //   }
              },
              backgroundColor: lentThemePrimary,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
