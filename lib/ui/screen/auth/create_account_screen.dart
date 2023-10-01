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
  late AuthProvider authProvider;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordRetypeController = TextEditingController();

  bool _passwordVisible = true;

  RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  @override
  void initState() {
    _generalSnackBar = GeneralSnackBar(context);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
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
      authProvider.createAccount(
          requestBody,
          RequestCallbacks(onSuccess: (response) {

            //_generalSnackBar.showSuccessSnackBar("Account created successfully");
            // Map<String, dynamic> jsonMap = json.decode(response);
            // AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
            // Provider.of<AuthProvider>(context, listen: false).storeDetails(AccountConfig.userDetail);
            context.go('/home');
          }, onError: (error) {
            _generalSnackBar.showErrorSnackBar("Error occurred while creating account please check the details");
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
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

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[

                      Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [BoxShadow(color: Color.fromRGBO(143, 148, 251, .2), blurRadius: 20.0, offset: Offset(0, 10))]),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                "Create new account",
                                style: header20,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: _nameController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(14))
                                      ),
                                      filled: true,
                                      fillColor: textWhiteGrey,
                                      hintText: "Name",
                                      errorText: authProvider.fieldErrors['name'],
                                      hintStyle: TextStyle(
                                        color: Colors.grey[900],
                                      )),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
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
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(14))
                                      ),
                                      filled: true,
                                      fillColor: textWhiteGrey,
                                      hintText: "Email",
                                      errorText: authProvider.fieldErrors['email'],
                                      hintStyle: TextStyle(color: Colors.grey[900])),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),

                                child: TextFormField(
                                  controller: _mobileNumberController,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter mobile number';
                                    } else if (value.toString().length != 10) {
                                      return "Please enter valid mobile number";
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    errorText: authProvider.fieldErrors['mobile'],
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(14))
                                    ),
                                    filled: true,
                                    fillColor: textWhiteGrey,
                                    hintText: "Mobile number",
                                    hintStyle: TextStyle(color: Colors.grey[900]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
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
                                    errorText: authProvider.fieldErrors['password'],
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(14))
                                    ),
                                    filled: true,
                                    fillColor: textWhiteGrey,
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
                                    errorText: authProvider.fieldErrors['password'],
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(14))
                                    ),
                                    filled: true,
                                    fillColor: textWhiteGrey,
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
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Button(width: 100, text: "Create account", onClick: () => {_validateAndSubmit()}),
                            ],
                          ),
                        ),
                      ),

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
    });
  }
}
