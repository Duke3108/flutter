import 'package:duke_shoes_shop/services/config.dart';
import '../models/sneaker_model.dart';
import 'package:http/http.dart' as https;

class Helper {
  var client = https.Client();

  Future<List<Sneakers>> getMaleSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.sneakers);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final maleList = sneakersFromJson(response.body);
      var male = maleList.where((element) => element.category == "giaynam");
      return male.toList();
    } else {
      throw Exception("Fail get sneakers list");
    }
  }

  Future<List<Sneakers>> getFemaleSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final femaleList = sneakersFromJson(response.body);
      var female = femaleList.where((element) => element.category == "giaynu");
      return female.toList();
    } else {
      throw Exception("Fail get sneakers list");
    }
  }

  Future<List<Sneakers>> getKidSneakers() async {
    var url = Uri.https(Config.apiUrl, Config.sneakers);

    var response = await client.get(url);

    if (response.statusCode == 200) {
      final kidList = sneakersFromJson(response.body);
      var kid = kidList.where((element) => element.category == "giaytreem");
      return kid.toList();
    } else {
      throw Exception("Fail get sneakers list");
    }
  }

  Future<List<Sneakers>> search(String searchquery) async {
    var url = Uri.https(Config.apiUrl, "${Config.search}$searchquery");
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final results = sneakersFromJson(response.body);

      return results;
    } else {
      throw Exception("Fail get sneakers list");
    }
  }
}
