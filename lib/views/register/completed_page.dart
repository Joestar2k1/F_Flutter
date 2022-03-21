import 'dart:ui';

import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:fluter_19pmd/views/register/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageCompleteSignUp extends StatefulWidget {
  const PageCompleteSignUp(
      {Key key, this.email, this.fullName, this.address, this.phone})
      : super(key: key);
  final String email;
  final String fullName;
  final String address;
  final String phone;

  @override
  State<PageCompleteSignUp> createState() => _PageCompleteSignUpState();
}

class _PageCompleteSignUpState extends State<PageCompleteSignUp> {
  final _isLoading = LoadingBloc();
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    _isLoading.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _submit(context, email, fullName, address, phone, password, username,
      confirm) async {
    _isLoading.loadingSink.add(true);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    if (password == confirm) {
      var dataFromServer = await RepositoryUser.register(
          username, fullName, email, password, phone, address);
      if (dataFromServer == 200) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                json: "assets/done.json",
                text: "Đăng ký tài khoản thành công.",
              );
            });
        _isLoading.loadingSink.add(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      } else {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                json: "assets/error.json",
                text: "Đăng ký thất bại.",
              );
            });
        _isLoading.loadingSink.add(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
        );
      }
    } else {
      _isLoading.loadingSink.add(false);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/error.json",
              text: "Mật khẩu không trùng khớp.",
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _form(size, context),
      ),
    );
  }

  Widget _form(size, context) => Form(
        key: _formKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: StreamBuilder<bool>(
              initialData: false,
              stream: _isLoading.loadingStream,
              builder: (context, state) {
                return Stack(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.shade600,
                              Colors.teal.shade200
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              "Đăng ký",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(30.0),
                              width: 500,
                              height: 400,
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _input(const Icon(Icons.person_add_alt_sharp),
                                      "Nhập tên hiện thị", usernameController),
                                  const SizedBox(height: 20),
                                  _input(const Icon(Icons.lock),
                                      "Nhập mật khẩu", passwordController),
                                  const SizedBox(height: 20),
                                  _input(const Icon(Icons.lock),
                                      "Nhập lại mật khẩu", confirmController),
                                  (state.data)
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Center(
                                            child: Lottie.asset(
                                                "assets/loading.json",
                                                width: 100,
                                                height: 50),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: _buttonGoOn(
                                            context,
                                            widget.email,
                                            widget.fullName,
                                            widget.address,
                                            widget.phone,
                                            usernameController.text,
                                            passwordController.text,
                                            confirmController.text,
                                          ),
                                        ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        "Quay lại",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _input(icon, text, controller) => TextFormField(
        controller: controller,
        obscureText: false,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey.shade500,
        ),
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
          prefixIcon: icon,
          floatingLabelStyle: TextStyle(
            fontSize: 22,
            color: Colors.grey.shade500,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorStyle: const TextStyle(fontSize: 18),
          labelText: text,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Không được bỏ trống';
          }
          return null;
        },
      );

  Widget _buttonGoOn(context, email, fullName, address, phone, username,
          password, confirm) =>
      Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () => _submit(context, email, fullName, address, phone,
                password, username, confirm),
            child: const Text('Đăng ký', style: TextStyle(fontSize: 18)),
          ),
        ),
      );
}
