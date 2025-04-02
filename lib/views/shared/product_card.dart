import 'package:duke_shoes_shop/controllers/login_provider.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/ui/auth/login.dart';
import 'package:duke_shoes_shop/views/ui/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/favorite_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

String formatPrice(String price) {
  int value = int.tryParse(price.replaceAll(',', '')) ?? 0;
  return NumberFormat('#,###').format(value * 100);
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: true);
    favoritesNotifier.getFavoritess();
    bool selected = true;
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(widget.image))),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: Consumer<FavoritesNotifier>(
                        builder: (context, favoritesNotifier, child) {
                          return Consumer<LoginNotifier>(
                            builder: (context, authNotifier, child) {
                              return GestureDetector(
                                onTap: () async {
                                  if (authNotifier.loggeIn == true) {
                                    if (favoritesNotifier.ids
                                        .contains(widget.id)) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Favorites()));
                                    } else {
                                      favoritesNotifier.createFav({
                                        "id": widget.id,
                                        "name": widget.name,
                                        "category": widget.category,
                                        "price": widget.price,
                                        "imageUrl": widget.image
                                      });
                                    }
                                    setState(() {});
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  }
                                },
                                child: favoritesNotifier.ids.contains(widget.id)
                                    ? Icon(AntDesign.heart)
                                    : Icon(AntDesign.hearto),
                              );
                            },
                          );
                        },
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    reusableText(
                      text: widget.name,
                      style: appStyleWithHt(
                          34, Colors.black, FontWeight.bold, 1.1),
                    ),
                    reusableText(
                      text: widget.category,
                      style:
                          appStyleWithHt(18, Colors.grey, FontWeight.bold, 1.5),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    reusableText(
                      text: formatPrice(widget.price),
                      style: appStyle(30, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: Text(""),
                          selected: selected,
                          showCheckmark: false,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                          shape: CircleBorder(),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
