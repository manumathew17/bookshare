import 'dart:convert';

import 'package:bookshare/config/account.dart';
import 'package:bookshare/provider/auth/auth_provider.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:bookshare/widget/components/sparkle.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../model/model_user.dart';
import '../../../network/callback.dart';
import '../../../network/request_route.dart';
import '../../../theme/app_style.dart';
import '../../../theme/colors.dart';
import '../../../widget/components/loader.dart';
import '../../../widget/components/snackbar.dart';
import '../../../widget/essentials/button.dart';


class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  CreateAccountScreenState createState() => CreateAccountScreenState();
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordRetypeController = TextEditingController();

  bool _passwordVisible = false;

  RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  @override
  void initState() {
    _generalSnackBar = GeneralSnackBar(context);

    super.initState();
  }

  _togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final requestBody = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordRetypeController.text,
        'mobile': _mobileNumberController.text
      };
      Loader.show(context);

      requestRouter.register(
          requestBody,
          RequestCallbacks(onSuccess: (response) {
            Sparkle.show(context);
            _generalSnackBar.showSuccessSnackBar("Account created successfully");
            Map<String, dynamic> jsonMap = json.decode(response);
            AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
            Provider.of<AuthProvider>(context, listen: false).storeDetails(AccountConfig.userDetail);
            context.go('/home');

          }, onError: (error) {
            _generalSnackBar.showErrorSnackBar("Registration failed");
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 50.w,
                child: Lottie.asset('assets/lottie/createacc.json'),
              ),
              const Text(
                "Create new account",
                style: header20,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                controller: _nameController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(border: InputBorder.none, hintText: "Name", hintStyle: TextStyle(color: Colors.grey[900])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter email id';
                                  } else if (!EmailValidator.validate(value.toString())) {
                                    return 'Please enter valid email id';
                                  }
                                  return null;
                                },
                                decoration:
                                    InputDecoration(border: InputBorder.none, hintText: "Email", hintStyle: TextStyle(color: Colors.grey[900])),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                controller: _mobileNumberController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Please enter mobile number';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mobile number",
                                  hintStyle: TextStyle(color: Colors.grey[900]),
                                  prefixText: '+91 ',
                                  prefixStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
                              child: TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Password cannot be empty';
                                  } else if (value!.length < 6) {
                                    return 'Password must be at least 6 character';
                                  }
                                  return null;
                                },
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[900]),
                                  suffixIcon: IconButton(
                                    color: textGrey,
                                    splashRadius: 1,
                                    icon: Icon(_passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                    onPressed: () => _togglePassword(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordRetypeController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Password cannot be empty';
                                  } else if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Retype Password",
                                  hintStyle: TextStyle(color: Colors.grey[900]),
                                  suffixIcon: IconButton(
                                    color: textGrey,
                                    splashRadius: 1,
                                    icon: Icon(_passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                    onPressed: () => _togglePassword(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Button(width: 100, text: "Create account", onClick: () => {_validateAndSubmit()}),
                    // Container(
                    //   height: 45,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: blackPrimary
                    //   ),
                    //   child: const Center(
                    //     child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    //   ),
                    // ),
                    SizedBox(
                      height: 2.h,
                    ),

                    Button(
                      width: 100,
                      text: "Login",
                      onClick: () => {Navigator.of(context).pop()},
                      backgroundColor: Colors.white,
                      textColor: blackPrimary,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
