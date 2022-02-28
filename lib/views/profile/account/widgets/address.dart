import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/user_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/services/profile/profile_bloc.dart';
import 'package:flutter/material.dart';

class AddressManagement extends StatefulWidget {
  const AddressManagement({Key key, this.addresses}) : super(key: key);
  final List<Address> addresses;

  @override
  State<AddressManagement> createState() => _AddressManagementState();
}

class _AddressManagementState extends State<AddressManagement> {
  final nameAddress = TextEditingController();
  final _profileBloc = ProfileBloc();
  @override
  void dispose() {
    super.dispose();
    nameAddress.dispose();
    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Address>>(
        initialData: widget.addresses,
        stream: _profileBloc.userAddressStream,
        builder: (context, snapshot) {
          return Card(
            shadowColor: Colors.teal,
            elevation: 10,
            margin: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeaderAddress(context),
                  const SizedBox(height: 20),
                  buildListAddress(context, snapshot.data),
                ],
              ),
            ),
          );
        });
  }

  Widget buildHeaderAddress(context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Danh sách địa chỉ",
            style: TextStyle(
              fontSize: 24,
              color: buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          _textButton(
              icon: Icons.add,
              press: () {
                _showMyDialog(context);
              }),
        ],
      );

  Widget _textButton({IconData icon, Function press}) => TextButton(
        onPressed: press,
        child: Icon(
          icon,
          color: buttonColor,
        ),
      );

  Widget buildListAddress(context, list) => SizedBox(
        height: RepositoryUser.getHeightAddress(),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 310,
                  height: 30,
                  child: Text(
                    '+${list[index].name}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: textColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var check =
                        await RepositoryUser.deleteAddress(list[index].id);
                    if (check == 200) {
                      checkOut('Xóa địa chỉ thành công');
                      _profileBloc.eventSink.add(UserEvent.fetchAddress);
                    } else {
                      checkOut('Xóa không được nhé');
                    }
                  },
                  child: Image.asset(
                    "assets/images/icons-png/trash.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            );
          },
        ),
      );

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Center(
            child: SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/icons-png/contact_details.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          content: Center(
            child: Column(
              children: [
                _input(),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text(
                    'Tạo mới',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () async {
                    var statusCode =
                        await RepositoryUser.createAddress(nameAddress.text);
                    Navigator.of(context).pop();
                    if (statusCode == 200) {
                      _profileBloc.eventSink.add(UserEvent.fetchAddress);
                      checkOut('Tạo địa chỉ thành công');
                    } else {
                      checkOut('Lỗi ............');
                    }
                  },
                ),
                TextButton(
                  child: const Text(
                    'Quay lại',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _input() => TextFormField(
        controller: nameAddress,
        obscureText: false,
        style: const TextStyle(fontSize: 20),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          labelText: "Nhập địa chỉ mới",
          labelStyle: TextStyle(fontSize: 20),
        ),
      );

  void checkOut(message) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        elevation: 10,
        backgroundColor: Colors.teal,
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Đã hiểu',
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ), // SnackBarAction
      ));
  }
}
