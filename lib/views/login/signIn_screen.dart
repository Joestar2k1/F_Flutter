import 'dart:async';
import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/forgot_password/forgot_page.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/home/home_page.dart';
import 'package:fluter_19pmd/views/register/signup_screen.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _isLoading = LoadingBloc();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _stateStreamController = StreamController<bool>();
  StreamSink<bool> get chooseSink => _stateStreamController.sink;
  Stream<bool> get chooseStream => _stateStreamController.stream;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _isLoading.dispose();
    _stateStreamController.close();
  }

  _submit(BuildContext context, String email, String password) async {
    _isLoading.loadingSink.add(true);
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      _isLoading.loadingSink.add(false);
      return;
    }
    _formKey.currentState.save();

    var check = await RepositoryUser.login(context, email, password);
    if (check == 200) {
      _isLoading.loadingSink.add(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
                title: "Thất bại",
                content: "-Hãy kiểm tra lại tài khoản.",
                gif: "assets/gif/fail.gif",
                textButton: "Okay");
          });
      _isLoading.loadingSink.add(false);
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
          body: _form(size),
        ),
      ),
    );
  }

  Widget _form(size) => Form(
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
                              Colors.teal.shade100
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 70,
                                child: Image.asset(
                                  "assets/images/Logo.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                "BE HEALTHY",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _emailLogin(),
                            _passwordLogin(),
                            const SizedBox(height: 30),
                            (state.data)
                                ? const Center(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage("assets/gif/loading.gif"),
                                    ),
                                  )
                                : _buttonLogin(context, emailController.text,
                                    passwordController.text),
                            const SizedBox(height: 20),
                            _forgotAndSignUp(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _emailLogin() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: const InputDecoration(
            floatingLabelStyle: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            errorStyle: TextStyle(fontSize: 18),
            labelText: "Enter email",
            labelStyle: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              return 'Enter a valid email!';
            }
            return null;
          },
        ),
      );

  Widget _passwordLogin() => StreamBuilder<bool>(
      initialData: true,
      stream: chooseStream,
      builder: (context, value) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: TextFormField(
            controller: passwordController,
            obscureText: value.data,
            style: const TextStyle(fontSize: 20),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              suffixStyle: const TextStyle(color: Colors.white),
              suffixIcon: InkWell(
                onTap: () {
                  chooseSink.add(!value.data);
                },
                child: (value.data)
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              floatingLabelStyle: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.0),
              ),
              errorStyle: const TextStyle(fontSize: 18),
              labelStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              labelText: "Enter password",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        );
      });

  Widget _buttonLogin(BuildContext context, String email, String password) =>
      Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () {
              _submit(context, email, password);
            },
            child: const Text('Đăng nhập', style: TextStyle(fontSize: 20)),
          ),
        ),
      );

  Widget _forgotAndSignUp() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Chưa có tài khoản?",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    ));
              },
              child: const Text(
                "Quên mật khẩu ?",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      );
}
