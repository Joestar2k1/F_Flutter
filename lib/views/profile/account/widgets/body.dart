import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/accoount_infomation.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountInfomation(),
          const SizedBox(height: 30),
          buildCardAddress(),
        ],
      ),
    );
  }

  Widget buildCardAddress() => Card(
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
              buildHeaderAddress(),
              const SizedBox(height: 30),
              buildListAddress(),
            ],
          ),
        ),
      );

  Widget buildHeaderAddress() => Row(
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
          TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Text(
                  "Sửa/thêm",
                  style: TextStyle(
                    fontSize: 24,
                    color: buttonColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.mode_edit_outline_outlined,
                  color: buttonColor,
                ),
              ],
            ),
          ),
        ],
      );

  Widget buildListAddress() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "+ 46 Phạm Thị Ngư, Tp.Phan Thiết",
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "+ 12 Hồ Thành Biên, Quận 8, Tp.Hồ Chí Minh",
            style: TextStyle(
              fontSize: 20,
              color: textColor,
            ),
          ),
        ],
      );
}
