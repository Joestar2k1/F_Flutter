import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void _submit(String email, String password) {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    print(RepositoryUser.login(email, password));
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
            child: _form(size),
          ),
        ),
      ),
    );
  }

  Widget _form(size) => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                const Text(
                  "Xin chào bạn",
                  style: TextStyle(
                    fontSize: 20,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome to Be Healthy!",
                  style: TextStyle(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _emailLogin(),
                const SizedBox(height: 20),
                _passwordLogin(),
                const SizedBox(height: 20),
                _buttonLogin(emailController.text, passwordController.text),
                const SizedBox(height: 20),
                _forgotAndSignUp(),
              ],
            ),
          ),
        ),
      );

  Widget _emailLogin() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: const InputDecoration(
            errorStyle: TextStyle(fontSize: 18),
            labelText: "Enter email",
            labelStyle: TextStyle(fontSize: 18),
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

  Widget _passwordLogin() => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: TextFormField(
          controller: passwordController,
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: const InputDecoration(
            focusedBorder: InputBorder.none,
            errorStyle: TextStyle(fontSize: 18),
            labelText: "Enter password",
            labelStyle: TextStyle(fontSize: 18),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      );

  Widget _buttonLogin(String email, String password) => Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () => _submit(email, password),
            child: const Text('Login', style: TextStyle(fontSize: 18)),
          ),
        ),
      );

  Widget _forgotAndSignUp() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Chưa có tài khoản?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Quên mật khẩu ?",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      );
}
