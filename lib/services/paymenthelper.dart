import 'dart:convert';
import 'package:duke_shoes_shop/models/order/orders_req.dart';
import 'package:duke_shoes_shop/services/config.dart';
import 'package:http/http.dart' as https;

class PaymentHelper {
  static var client = https.Client();

  Future<String> payment(Order model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.paymentBaseUrl, Config.paymentUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      var payment = jsonDecode(response.body);
      return payment['url'];
    } else {
      return 'failed';
    }
  }
}
