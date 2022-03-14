import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/favorites_api.dart';
import 'package:fluter_19pmd/repository/products_api.dart';
import 'package:fluter_19pmd/views/details_product/details_product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemFavorite extends StatefulWidget {
  ItemFavorite({Key key, this.products, this.title}) : super(key: key);
  List<Product> products = [];
  final String title;
  @override
  State<ItemFavorite> createState() => _ItemFavoriteState();
}

class _ItemFavoriteState extends State<ItemFavorite> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.teal.shade200],
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          elevation: 0.5,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        body: (widget.products == null)
            ? Center(
                child: Text(
                  'Bộ yêu thích hiện tại đang trống!!!',
                  style: TextStyle(fontSize: 22, color: Colors.grey.shade600),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height:
                    RepositoryFavorite.getHeightItem(widget.products.length),
                child: ListView.builder(
                    itemCount: widget.products.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          RepositoryProduct.getID = widget.products[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DetailsProductScreen(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.network(
                                widget.products[index].image,
                                width: 130,
                                height: 130,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/icons-png/Check.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      Text(
                                        widget.products[index].name,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    width: size.width * 0.6,
                                    height: 50,
                                    child: Text(
                                      '-${widget.products[index].description}',
                                      style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.grey.shade600,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: _buildItemInfo(
                                        text: "Giá bán:",
                                        number: widget.products[index].price,
                                        unit: widget.products[index].unit,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }

  Widget _buildItemInfo({String text, int number, String unit}) => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 19,
                color: Colors.grey.shade600,
              ),
            ),
            TextSpan(
              text: '${convertToVND(number)}đ',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: '/$unit',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      );
}
