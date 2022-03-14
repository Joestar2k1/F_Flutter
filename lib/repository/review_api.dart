import 'package:fluter_19pmd/models/product_models.dart';
import 'package:fluter_19pmd/repository/user_api.dart';
import 'package:http/http.dart' as http;

class RepositoryReview {
  static int starNumber;
  static Future<dynamic> post(
      {int starNumber, String content, List<Product> productID}) async {
    var client = http.Client();
    var statusCode;
    for (var element in productID) {
      await client.post(
          Uri.parse('http://10.0.2.2:8000/api/reviews/post-comment'),
          body: ({
            'userID': RepositoryUser.info.id,
            'productID': element.id,
            'content': content,
            'quantity': starNumber.toString(),
          }));
      statusCode = 200;
    }

    if (statusCode == 200) {
      return 200;
    } else {
      return 201;
    }
  }
}
