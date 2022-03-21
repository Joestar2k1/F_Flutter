import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:toast/toast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _isLoading = LoadingBloc();
  final emailController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    _isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(backgroundColor: Colors.white, body: _form(size)),
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
              Container(
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
              Center(
                child: StreamBuilder<bool>(
                    initialData: false,
                    stream: _isLoading.loadingStream,
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const Text(
                              "Quên mật khẩu",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(30.0),
                              width: 500,
                              height: 280,
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
                                  Text(
                                    "Nhập Email mà bạn đã đăng ký",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: _emailLogin(),
                                  ),
                                  (!state.data)
                                      ? _buttonLogin(
                                          context, emailController.text)
                                      : Center(
                                          child: Lottie.asset(
                                              "assets/loading.json",
                                              width: 100,
                                              height: 50),
                                        ),
                                  const SizedBox(
                                    height: 20,
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
                      );
                    }),
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
          errorStyle: const TextStyle(fontSize: 18),
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

  Widget _buttonLogin(BuildContext context, String email) => Center(
        child: SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonColor),
            ),
            onPressed: () {
              _submit(context, email);
            },
            child: const Text('Gửi email', style: TextStyle(fontSize: 18)),
          ),
        ),
      );

  void _submit(BuildContext context, String email) async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    _isLoading.loadingSink.add(true);
    await sendEmail(email);
  }

  Future sendEmail(String email) async {
    String username = 'iloverussian2311@gmail.com';
    String password = '23112001aZ';
    var data = await RepositoryUser.forgotPassword(email);

    if (data == "Thất bại") {
      _isLoading.loadingSink.add(false);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDiaLogCustom(
              json: "assets/error.json",
              text: "Email của bạn chưa có trong hệ thống.",
            );
          });
    } else {
      // ignore: deprecated_member_use
      final smtpServer = gmail(username, password);
      final message = Message()
        ..from = Address(username, 'BeHealthy C9')
        ..recipients.add(email)
        ..ccRecipients.addAll([email, email])
        ..bccRecipients.add(Address(email))
        ..subject = 'Bạn đã quên mật khẩu 😀 ${DateTime.now()}'
        ..html =
            "<h1>Xin chào</h1>\n<p>Mật khẩu mới của tài khoản $email là $data</p>\n<p>Chúc bạn một ngày tốt lành</p>";

      try {
        final sendReport = await send(message, smtpServer);

        await showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                json: "assets/done.json",
                text: "Kiểm tra hòm thư email của bạn.",
              );
            });
        _isLoading.loadingSink.add(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      } on MailerException catch (e) {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                json: "assets/error.json",
                text: "Email không phản hồi.",
              );
            });

        var connection = PersistentConnection(smtpServer);
        await connection.send(message);
        await connection.close();
      }
    }
  }
}
