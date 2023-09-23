import 'package:bookshare/model/model_book.dart';
import 'package:bookshare/model/model_user.dart';
import 'package:bookshare/network/callback.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../network/request_route.dart';
import '../../../../theme/app_style.dart';
import '../../../../theme/colors.dart';
import '../../../../widget/components/loader.dart';

class EditProfile extends StatefulWidget {
  final UserDetail userDetail;
  final VoidCallback onUpdate;

  const EditProfile({
    super.key,
    required this.onUpdate,
    required this.userDetail,
  });

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userDetail.user.name;
    emailController.text = widget.userDetail.user.email;
    mobileNumberController.text = widget.userDetail.user.mobile;
    addressController.text =widget.userDetail.user.address;
    _generalSnackBar = GeneralSnackBar(context);
  }

  _updateUserProfile(String name, String email, String mobileNumber, String address) {
    final requestBody = {"name": name, "email": email, "mobile": mobileNumber, "address": address};
    Loader.show(context);
    requestRouter.updateProfile(
        requestBody,
        RequestCallbacks(onSuccess: (_) {
          widget.onUpdate();
        }, onError: (_) {
          _generalSnackBar.showErrorSnackBar("Error happened");
        }));
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
              const Text('Update details', style: header20),
              SizedBox(
                height: 2.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: const Text('Name'),
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
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        label: const Text('Email'),
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
                          return 'Please enter email id';
                        } else if (!EmailValidator.validate(value.toString())) {
                          return 'Please enter valid email id';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: mobileNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: const Text('Mobile number'),
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
                          return 'Please enter mobile number';
                        } else if (value.toString().length != 10) {
                          return "Please enter valid mobile number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),


                    TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        label: const Text('Address'),
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
                          return 'Please enter address';
                        } else if (value.toString().length < 10) {
                          return "Please enter valid address";
                        } else {
                          return null;
                        }
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
                      backgroundColor: MaterialStateProperty.all<Color>(yellowPrimary), // Set the button background color to blue
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Change the border radius here
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _updateUserProfile(nameController.text, emailController.text, mobileNumberController.text, addressController.text);
                        //_updateCustomerDetails(nameController.text, mobileController.text);
                      }
                    },
                    child: const Text('Update', style: header12,),
                  ),
                ],
              ),
              SizedBox(height: 3.w),
            ],
          ),
        ),
      ),
    );
  }


}
