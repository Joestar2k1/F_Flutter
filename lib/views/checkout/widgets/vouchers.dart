import 'package:flutter/material.dart';

class VoucherList extends StatefulWidget {
  const VoucherList({Key key}) : super(key: key);

  @override
  State<VoucherList> createState() => _VoucherListState();
}

class _VoucherListState extends State<VoucherList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Card(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _contentLeftVoucher(),
                  Container(
                      margin: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                                  width: 10.0, color: Color(0xffffdfdfdf)))),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Chọn',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue,
                          ),
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }

  Widget _contentLeftVoucher() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'MGad12u111',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '-20.000đ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 200,
            child: Text(
              'Nhân dịp ngày 8/3',
              style: TextStyle(
                fontSize: 20,
                color: Colors.teal,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
          Text(
            'HSD: 2022-03-10',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
