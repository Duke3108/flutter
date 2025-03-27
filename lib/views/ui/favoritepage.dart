import 'package:cached_network_image/cached_network_image.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/ui/mainscreen.dart';
import 'package:duke_shoes_shop/views/ui/nonuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/favorite_provider.dart';
import '../../controllers/login_provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

String catChuoi(String text, int length) {
  return text.length > length ? '${text.substring(0, length)}...' : text;
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();
    var authNotifier = Provider.of<LoginNotifier>(context);
    return authNotifier.loggeIn == false
        ? NonUser()
        : Scaffold(
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(16, 30, 0, 0),
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/top_image.png"),
                              fit: BoxFit.fill)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Yêu thích",
                          style: appStyle(
                            40,
                            Colors.white,
                            FontWeight.bold,
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                        itemCount: favoritesNotifier.fav.length,
                        padding: EdgeInsets.only(top: 100),
                        itemBuilder: (BuildContext context, int index) {
                          final shoe = favoritesNotifier.fav[index];
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade500,
                                          spreadRadius: 5,
                                          blurRadius: 0.3,
                                          offset: Offset(0, 1))
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(12),
                                          child: CachedNetworkImage(
                                            imageUrl: shoe['imageUrl'],
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 12, left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                catChuoi(shoe['name'], 20),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: appStyle(
                                                    16,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                shoe['category'],
                                                style: appStyle(14, Colors.grey,
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    NumberFormat('#,###')
                                                        .format(int.parse(
                                                            shoe['price']
                                                                .replaceAll(
                                                                    ',', ''))),
                                                    style: appStyle(
                                                        18,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: () {
                                          favoritesNotifier
                                              .deleteFav(shoe['key']);
                                          favoritesNotifier.ids.removeWhere(
                                              (element) =>
                                                  element == shoe['id']);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MainScreen()));
                                        },
                                        child: Icon(Ionicons.md_heart_dislike),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
