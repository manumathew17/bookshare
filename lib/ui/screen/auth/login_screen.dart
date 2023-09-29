import 'dart:convert';

import 'package:bookshare/config/account.dart';
import 'package:bookshare/model/model_user.dart';
import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/widget/essentials/button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../network/callback.dart';
import '../../../network/request_route.dart';
import '../../../provider/auth/auth_provider.dart';
import '../../../theme/app_style.dart';
import '../../../widget/components/loader.dart';
import '../../../widget/components/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = true;

  RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  @override
  void initState() {
    super.initState();
    _generalSnackBar = GeneralSnackBar(context);
  }

  _togglePassword() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      final requestBody = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      Loader.show(context);
      requestRouter.validateUser(
          requestBody,
          RequestCallbacks(onSuccess: (response) async{
            Map<String, dynamic> jsonMap = json.decode(response);
            AccountConfig.userDetail = UserDetail.fromJson(jsonMap);
            Provider.of<AuthProvider>(context, listen: false).storeDetails(AccountConfig.userDetail);
            final authProvider = Provider.of<AuthProvider>(context, listen: false);
            final isLogged = await authProvider.isLoggedIn();
            context.go('/home');
          }, onError: (error) {
            _generalSnackBar.showErrorSnackBar("Authentication failed");
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
                height: 10.h,
              ),
              SizedBox(
                width: 50.w,
                child: Lottie.asset('assets/lottie/login.json'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Login",
                              style: header20,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Email or Phone number cannot be empty';
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
                                    hintText: "Email or Phone number", hintStyle: TextStyle(color: Colors.grey[900])),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Password cannot be empty';
                                  }
                                  return null;
                                },
                                obscureText: _passwordVisible,
                                decoration: InputDecoration(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Button(width: 100, text: "Login", onClick: () => {_validateAndSubmit()}),
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
                      height: 1.h,
                    ),
                    Button(
                      width: 100,
                      text: "Create Account",
                      onClick: () => {GoRouter.of(context).push("/create-account")},
                      backgroundColor: Colors.white,
                      textColor: blackPrimary,
                    )

                    // GestureDetector(
                    //   onTap: () => {GoRouter.of(context).push("/create-account")},
                    //   child: const Text(
                    //     "Create account",
                    //     style: TextStyle(color: primaryDark),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
