import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/register/completed_page.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  void _submit(context, email, fullName, address, phone) {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save(); // SnackBar
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageCompleteSignUp(
          email: email.text,
          fullName: fullName.text,
          address: address.text,
          phone: phone.text,
        ),
      ),
    );
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
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade200],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
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
                      _emailLogin(),
                      const SizedBox(height: 10),
                      _input("Enter họ tên", fullNameController),
                      const SizedBox(height: 10),
                      _input("Enter địa chỉ", addressController),
                      const SizedBox(height: 10),
                      _input("Enter số điện thoại", phoneController),
                      const SizedBox(height: 10),
                      _buttonGoOn(context, emailController, fullNameController,
                          addressController, phoneController),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _emailLogin() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          controller: emailController,
          style: const TextStyle(fontSize: 20),
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
              return 'Không hợp lệ, phải chứa @!';
            }
            return null;
          },
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
            floatingLabelStyle: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3.0),
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3.0)),
            errorStyle: const TextStyle(fontSize: 18),
            labelText: text,
            labelStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Không được bỏ trống';
            }
            return null;
          },
        ),
      );

  Widget _buttonGoOn(context, email, fullName, address, phone) => Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () => _submit(context, email, fullName, address, phone),
            child: const Text('Tiếp Tục', style: TextStyle(fontSize: 18)),
          ),
        ),
      );
}
