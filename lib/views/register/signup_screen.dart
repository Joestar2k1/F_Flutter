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
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
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
                      height: 580,
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
                          _emailLogin(),
                          const SizedBox(height: 20),
                          _input(const Icon(Icons.account_box), "Enter họ tên",
                              fullNameController),
                          const SizedBox(height: 20),
                          _input(const Icon(Icons.location_city),
                              "Enter địa chỉ", addressController),
                          const SizedBox(height: 20),
                          _input(const Icon(Icons.phone_android),
                              "Enter số điện thoại", phoneController),
                          const SizedBox(height: 20),
                          _buttonGoOn(
                              context,
                              emailController,
                              fullNameController,
                              addressController,
                              phoneController),
                          const SizedBox(height: 20),
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
            ],
          ),
        ),
      );

  Widget _emailLogin() => TextFormField(
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey.shade500,
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        onFieldSubmitted: (value) {},
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email_outlined),
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
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorStyle: const TextStyle(fontSize: 16),
          labelText: "Enter email",
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade500,
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
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          errorStyle: const TextStyle(fontSize: 16),
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
