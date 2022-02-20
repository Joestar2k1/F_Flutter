import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:fluter_19pmd/views/profile/account/widgets/account_information.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('widget-account');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AccountInformation(),
          const SizedBox(height: 30),
          buildCardAddress(context),
        ],
      ),
    );
  }

  Widget buildCardAddress(context) => Card(
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
              buildListAddress(context),
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

  Widget buildListAddress(context) => SizedBox(
        height: RepositoryUser.getHeightAddress(),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemCount: RepositoryUser.info.address.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '+${RepositoryUser.info.address[index].name}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
              ],
            );
          },
        ),
      );
}
