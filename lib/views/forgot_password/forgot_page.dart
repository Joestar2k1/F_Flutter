import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/bloc/loading_bloc.dart';
import 'package:fluter_19pmd/views/login/signIn_screen.dart';
import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: StreamBuilder<bool>(
                initialData: false,
                stream: _isLoading.loadingStream,
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.network(
                          'https://www.freeiconspng.com/uploads/forgot-password-icon-8.jpg',
                          width: 250,
                          height: 250,
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              const Icon(Icons.arrow_back, color: Colors.teal),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Text(
                          "Nhập Email mà bạn đã đăng ký",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _email(),
                        const SizedBox(height: 20),
                        _buttonLogin(context, emailController.text),
                        (state.data)
                            ? Column(
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: const [
                                      Text(
                                        "Đang gửi vui lòng chờ trong giây lát..",
                                        style: TextStyle(
                                            color: Colors.teal, fontSize: 20),
                                      ),
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
          ),
        ),
      );
  Widget _email() => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: TextFormField(
          controller: emailController,
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          onFieldSubmitted: (value) {},
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            errorStyle: TextStyle(fontSize: 18),
            labelText: "Nhập email",
            labelStyle: TextStyle(fontSize: 20),
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
                title: "Thất bại",
                content: "-Email của bạn chưa được đăng ký trong hệ thống!.",
                gif: "assets/gif/fail.gif",
                textButton: "Okay");
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

        showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                  title: "Thành công",
                  content: "-Bạn hãy kiểm tra hòm thư Email của mình.",
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
      } on MailerException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDiaLogCustom(
                  title: "Thất bại",
                  content: "-Email không phản h!.",
                  gif: "assets/gif/fail.gif",
                  textButton: "Okay");
            });
      }

      var connection = PersistentConnection(smtpServer);
      await connection.send(message);
      await connection.close();
    }
  }
}
