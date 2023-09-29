import 'dart:convert';

import 'package:bookshare/config/account.dart';
import 'package:bookshare/config/const.dart';
import 'package:bookshare/model/model_user.dart';
import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../theme/colors.dart';
import '../../../widget/components/sparkle.dart';
import '../../../widget/essentials/button.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressLine1 = TextEditingController();
  final TextEditingController _addressLine2 = TextEditingController();
  final TextEditingController _addressLine3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              width: 50.w,
              child: Lottie.asset('assets/lottie/location.json'),
            ),
            const Text(
              "Add Address",
              style: header20,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _addressLine1,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Near HSR Layout',
                            label: const Text('Address line 1'),
                            hintStyle: header12.copyWith(color: textGrey),
                            border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(14))),
                            filled: true,
                            fillColor: textWhiteGrey,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter address';
                            } else if (value.toString().length < 10) {
                              return "Please enter valid address";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addressLine2,
                          keyboardType: TextInputType.text,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Karnataka',
                            label: const Text('State'),
                            hintStyle: header12.copyWith(color: textGrey),
                            border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(14))),
                            filled: true,
                            fillColor: textWhiteGrey,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Please enter state';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addressLine3,
                          decoration: InputDecoration(
                            label: const Text('Country'),
                            hintText: 'India',
                            hintStyle: header12.copyWith(color: textGrey),
                            border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(14))),
                            filled: true,
                            fillColor: textWhiteGrey,
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter country';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Button(width: 100, text: "Proceed", onClick: () => {_saveAddress()}),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _saveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      _updateAddress(_addressLine1.text, _addressLine2.text, _addressLine3.text);
      //_updateCustomerDetails(nameController.text, mobileController.text);
    }
    //context.go('/home');
  }

  _updateAddress(address, state, country) {
    RequestRouter requestRouter = RequestRouter();
    GeneralSnackBar generalSnackBar = GeneralSnackBar(context);
    final postBody = {"address": address, 'state': state, 'country':country};
    print(postBody);
    print(postBody);
    requestRouter.updateProfile(
        postBody,
        RequestCallbacks(
            onSuccess: (response) {
              Map<String, dynamic> jsonMap = json.decode(response);
              AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
              storeDetails(AccountConfig.userDetail);
              Sparkle.show(context);
              context.go('/home');
            },
            onError: (error) => {generalSnackBar.showErrorSnackBar("Error while adding address please retry")}));
  }
   Future<bool> storeDetails(UserDetail userDetail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonMap = userDetail.toJson();
    final jsonString = jsonEncode(jsonMap);
    return await prefs.setString(SharedPrefKeys.login.name, jsonString);
  }
}
