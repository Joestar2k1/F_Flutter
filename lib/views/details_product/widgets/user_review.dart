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
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.35,
                height: 1,
                color: Colors.black,
              ),
              const Text(
                "Đánh giá",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Container(
                width: size.width * 0.35,
                height: 1,
                color: Colors.black,
              ),
            ],
          ),
          (userReview == null)
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.teal,
                ))
              : (RepositoryProduct.getHeightForUserReview() == 0)
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
                          RepositoryProduct.getHeightForUserReview(),
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userReview.length,
                          itemBuilder: (
                            context,
                            index,
                          ) {
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
                                          Text(
                                            userReview[index].fullName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          _star(
                                              userReview[index].quantity, index)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 20.0),
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
                            );
                          }),
                    ),
        ],
      ),
    );
  }

  Widget _star(quantity, index) => (quantity == 1)
      ? Row(
          children: [
            const Icon(Icons.star, color: Colors.yellow),
            const SizedBox(width: 10),
            Text("${userReview[index].quantity} sao"),
          ],
        )
      : (quantity == 2)
          ? Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                const Icon(Icons.star, color: Colors.yellow),
                const SizedBox(width: 10),
                Text("${userReview[index].quantity} sao"),
              ],
            )
          : (quantity == 3)
              ? Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const Icon(Icons.star, color: Colors.yellow),
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 10),
                    Text("${userReview[index].quantity} sao"),
                  ],
                )
              : (quantity == 4)
                  ? Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 10),
                        Text("${userReview[index].quantity} sao"),
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 10),
                        Text("${userReview[index].quantity} sao"),
                      ],
                    );
}
