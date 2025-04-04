import 'dart:convert';

import 'package:duke_shoes_shop/models/cart/add_to_cart.dart';
import 'package:duke_shoes_shop/models/cart/get_products.dart';
import 'package:duke_shoes_shop/models/order/orders_res.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class CartHelper {
  static var client = https.Client();

  Future<bool> addToCart(AddToCart model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };

    var url = Uri.https(Config.apiUrl, Config.addCartUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Product>> getCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };

    var url = Uri.https(Config.apiUrl, Config.getCartUrl);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<Product> cart = [];
      var products = jsonData[0]['products'];
      cart = List<Product>.from(
          products.map((product) => Product.fromJson(product)));
      return cart;
    } else {
      throw Exception("Failed to get cart items");
    }
  }

  Future<bool> deleteItem(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };

    var url = Uri.https(Config.apiUrl, "${Config.addCartUrl}/$id");

    var response = await client.delete(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<PaidOrders>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $userToken'
    };

    var url = Uri.https(Config.apiUrl, Config.orders);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var products = paidOrdersFromJson(response.body);
      return products;
    } else {
      throw Exception("Failed to get orders");
    }
  }
}
