import 'package:fluter_19pmd/views/profile/account/widgets/edit_account.dart';
import 'package:flutter/material.dart';

class ItemAccount extends StatelessWidget {
  ItemAccount({Key key}) : super(key: key);
  final List infoAccount = List.unmodifiable([
    {'text': "Joestar2k1", 'title': 'Tên đăng nhập'},
    {'text': "Nguyễn Hoài Chương", 'title': 'Họ tên'},
    {'text': "abcxyz", 'title': 'Thay đổi mật khẩu'},
    {'text': "Nam", 'title': 'Giới tính'},
    {'text': "09*****", 'title': 'Số điện thoại'},
    {'text': " ", 'title': 'Thiết lập địa chỉ'},
  ]);

  heightContainer() {
    double dem = 0;
    for (int i = 0; i < infoAccount.length; i++) {
      dem += 0.07;
    }
    return dem;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.81,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: infoAccount.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditAccountPage(),
                      settings: RouteSettings(arguments: {
                        infoAccount[index]['title'],
                        infoAccount[index]['text'],
                      }),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width,
                  height: size.height * 0.1,
                  color: Colors.orange.withOpacity(0.2),
                  child: ListTile(
                    leading: Text(
                      infoAccount[index]['title'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    title: Text(
                      infoAccount[index]['text'],
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_right,
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
