import 'dart:ui';

import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:fluter_19pmd/views/register/signup_screen.dart';
import 'package:flutter/material.dart';

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
        showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                  title: "Thành công",
                  content: "-Đã đăng ký tài khoản BEHEALTHY.",
                  gif: "assets/gif/success.gif",
                  textButton: "Okay");
            });
        _isLoading.loadingSink.add(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                  title: "Thất bại",
                  content: "-Xảy ra lỗi, hãy thử lại.",
                  gif: "assets/gif/404.gif",
                  textButton: "Okay");
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
                title: "Thất bại",
                content: "-Mật khẩu không trùng khớp, vui lòng nhập lại!.",
                gif: "assets/gif/warning.gif",
                textButton: "Okay");
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: _form(size, context),
          ),
        ),
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
                    SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ),
                                );
                              },
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white)),
                          const Text(
                            "Xin chào bạn",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Đây là trang đăng ký!",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _input("Enter tên hiện thị", usernameController),
                          const SizedBox(height: 10),
                          _input("Enter mật khẩu", passwordController),
                          const SizedBox(height: 10),
                          _input("Enter Nhập lại mật khẩu", confirmController),
                          (state.data)
                              ? Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Đang xử lý',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: AssetImage(
                                            "assets/gif/loading.gif"),
                                      )
                                    ],
                                  ),
                                )
                              : _buttonGoOn(
                                  context,
                                  widget.email,
                                  widget.fullName,
                                  widget.address,
                                  widget.phone,
                                  usernameController.text,
                                  passwordController.text,
                                  confirmController.text,
                                ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _input(text, controller) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: TextFormField(
          controller: controller,
          obscureText: false,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(fontSize: 18),
            labelText: text,
            labelStyle: const TextStyle(fontSize: 20),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống';
            }
            return null;
          },
        ),
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
