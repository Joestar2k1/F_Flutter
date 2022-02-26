import 'package:fluter_19pmd/function.dart';
import 'package:fluter_19pmd/models/product_models.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({Key key, this.itemProduct}) : super(key: key);
  final List<Product> itemProduct;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: itemProduct.length,
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _item(value: itemProduct[index].name),
            const SizedBox(width: 20),
            _item(value: '${convertToVND(itemProduct[index].price)}đ'),
            const SizedBox(width: 20),
            _item(value: 'x${itemProduct[index].quantity}'),
            const SizedBox(width: 20),
            Container(
              color: Colors.teal,
              child: Image.asset(
                "assets/images/products/${itemProduct[index].image}",
                height: 80,
                width: 80,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item({String value}) => Container(
        width: 80,
        height: 80,
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
}