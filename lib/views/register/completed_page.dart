import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
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
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _submit(
      context, email, fullName, address, phone, password, username) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    var dataFromServer = await RepositoryUser.register(
        username, fullName, email, password, phone, address);
    if (dataFromServer == 200) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text(
              "Đăng ký thành công",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            action: SnackBarAction(
              label: "OK",
              textColor: Colors.teal,
              onPressed: () {},
            ),
          ),
        );
      Future.delayed(const Duration(seconds: 2));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
      );
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
                  height: size.height * 0.05,
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
                  "Đây là trang đăng ký!",
                  style: TextStyle(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _input("Enter tên hiện thị", usernameController),
                const SizedBox(height: 10),
                _input("Enter mật khẩu", passwordController),
                const SizedBox(height: 10),
                _input("Enter Nhập lại mật khẩu", confirmController),
                _buttonGoOn(
                  context,
                  widget.email,
                  widget.fullName,
                  widget.address,
                  widget.phone,
                  usernameController.text,
                  passwordController.text,
                ),
              ],
            ),
          ),
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
            focusedBorder: InputBorder.none,
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

  Widget _buttonGoOn(
          context, email, fullName, address, phone, username, password) =>
      Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () => _submit(
                context, email, fullName, address, phone, password, username),
            child: const Text('Đăng ký', style: TextStyle(fontSize: 18)),
          ),
        ),
      );
}
