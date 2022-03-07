import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:flutter/material.dart';

class ItemFavorite extends StatefulWidget {
  const ItemFavorite({Key key, this.products}) : super(key: key);
  final List<Product> products;
  @override
  State<ItemFavorite> createState() => _ItemFavoriteState();
}

class _ItemFavoriteState extends State<ItemFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: RepositoryFavorite.getHeightItem(widget.products.length),
      child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.products[index].name,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.grey.shade500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'giá : ${convertToVND(widget.products[index].price)}đ',
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/images/icons-png/trash.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
