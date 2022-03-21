import 'package:fluter_19pmd/models/reviews_models.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:flutter/material.dart';

class UserReview extends StatelessWidget {
  const UserReview({Key key, this.userReview}) : super(key: key);
  final List<Review> userReview;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(size),
          (RepositoryProduct.getHeightForUserReview(userReview.length) == 0)
              ? Column(
                  children: const [
                    SizedBox(height: 60),
                    Center(
                        child: Text(
                      "Chưa có đánh giá ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ],
                )
              : SizedBox(
                  height: size.height *
                      RepositoryProduct.getHeightForUserReview(
                          userReview.length),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userReview.length,
                      itemBuilder: (context, index) {
                        final currentTime = DateTime.now();
                        final orderDate = DateTime.parse(
                            userReview[index].postedDate.toString());
                        final results = currentTime.difference(orderDate);
                        final ymdCurrent = currentTime.year.toString() +
                            '-' +
                            currentTime.month.toString().padLeft(2, '0') +
                            '-' +
                            currentTime.day.toString().padLeft(2, '0');
                        final ymdOrder = orderDate.year.toString() +
                            '-' +
                            orderDate.month.toString().padLeft(2, '0') +
                            '-' +
                            orderDate.day.toString().padLeft(2, '0');

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                    child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                      "assets/images/person/${userReview[index].avatar}",
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            userReview[index].fullName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          _timeComment(
                                            results: results,
                                            orderDate: ymdOrder,
                                            currentTime: ymdCurrent,
                                            oD: orderDate,
                                            cT: currentTime,
                                          )
                                        ],
                                      ),
                                      _star(userReview[index].quantity, index)
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.network(
                                      'https://cf.shopee.vn/file/02c1c1a08defeb84e8aef5495ff5dd02',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    width: 280,
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.only(left: 20.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    child: Text(
                                      userReview[index].content,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.teal.shade700,
                                        letterSpacing: 1.0,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        // overflow: TextOverflow.clip,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }

  Row _header(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * 0.35,
          height: 1,
          color: Colors.black,
        ),
        const Text(
          "Đánh giá",
          style: TextStyle(fontSize: 24, color: Colors.teal),
        ),
        Container(
          width: size.width * 0.35,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }

  // ignore: missing_return
  Widget _timeComment({results, orderDate, currentTime, oD, cT}) {
    if (orderDate == currentTime) {
      if (oD.hour == cT.hour && oD.minute != cT.minute) {
        return Text(
          '${results.inMinutes} phút trước',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      } else if (oD.hour != cT.hour) {
        return Text(
          '${results.inHours} giờ trước',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      } else {
        return Text(
          '${results.inSeconds} giây trước',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      }
    } else {
      if (oD.month == cT.month && oD.day != cT.day) {
        return Text(
          '${results.inDays} ngày trước',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      } else if (oD.month != cT.month &&
          cT.year == oD.year &&
          cT.month - oD.month < 13) {
        return Text(
          '${cT.month - oD.month} tháng trước',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      } else {
        return Text(
          '$orderDate',
          style: TextStyle(fontSize: 18, color: Colors.grey.shade400),
        );
      }
    }
  }

  Widget _star(quantity, index) => (quantity == 1)
      ? Row(
          children: const [
            Icon(Icons.star, color: Colors.yellow),
          ],
        )
      : (quantity == 2)
          ? Row(
              children: const [
                Icon(Icons.star, color: Colors.yellow),
                Icon(Icons.star, color: Colors.yellow),
              ],
            )
          : (quantity == 3)
              ? Row(
                  children: const [
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                    Icon(Icons.star, color: Colors.yellow),
                  ],
                )
              : (quantity == 4)
                  ? Row(
                      children: const [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    )
                  : Row(
                      children: const [
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                        Icon(Icons.star, color: Colors.yellow),
                      ],
                    );
}
