import 'package:cached_network_image/cached_network_image.dart';
import 'package:duke_shoes_shop/controllers/favorite_provider.dart';
import 'package:duke_shoes_shop/controllers/product_provider.dart';
import 'package:duke_shoes_shop/models/cart/add_to_cart.dart';
import 'package:duke_shoes_shop/services/carthelper.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/login_provider.dart';
import '../../models/sneaker_model.dart';
import '../shared/checkout_btn.dart';
import 'favoritepage.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.sneakers});

  final Sneakers sneakers;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    var favoritesNotifier =
        Provider.of<FavoritesNotifier>(context, listen: false);
    favoritesNotifier.getFavoritess();
    return Scaffold(body:
        Consumer<ProductNotifier>(builder: (context, productNotifier, child) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 0,
            title: Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      //productNotifier.shoeSizes.clear();
                    },
                    child: Icon(
                      AntDesign.close,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (authNotifier.loggeIn == true) {
                        if (favoritesNotifier.ids
                            .contains(widget.sneakers.id)) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorites()));
                        } else {
                          favoritesNotifier.createFav({
                            "id": widget.sneakers.id,
                            "name": widget.sneakers.name,
                            "category": widget.sneakers.category,
                            "price": widget.sneakers.price,
                            "imageUrl": widget.sneakers.imageUrl[0]
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
                    child: favoritesNotifier.ids.contains(widget.sneakers.id)
                        ? Icon(
                            AntDesign.heart,
                            color: Colors.black,
                          )
                        : Icon(
                            AntDesign.hearto,
                            color: Colors.black,
                          ),
                  )
                ],
              ),
            ),
            pinned: true,
            snap: false,
            floating: true,
            backgroundColor: Colors.transparent,
            expandedHeight: MediaQuery.of(context).size.height,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sneakers.imageUrl.length,
                        controller: pageController,
                        onPageChanged: (page) {
                          productNotifier.activePage = page;
                        },
                        itemBuilder: (context, int index) {
                          return Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.40,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: widget.sneakers.imageUrl[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                        widget.sneakers.imageUrl.length,
                                        (index) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4),
                                              child: CircleAvatar(
                                                radius: 5,
                                                backgroundColor: productNotifier
                                                            .activepage !=
                                                        index
                                                    ? Colors.grey
                                                    : Colors.black,
                                              ),
                                            )),
                                  )),
                            ],
                          );
                        }),
                  ),
                  Positioned(
                      bottom: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.645,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.sneakers.name,
                                  style: appStyle(
                                      38, Colors.black, FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.sneakers.category,
                                      style: appStyle(
                                          20, Colors.grey, FontWeight.w500),
                                    ),
                                    SizedBox(width: 20),
                                    RatingBar.builder(
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 22,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        size: 18,
                                        color: Colors.black,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      NumberFormat('###,###.###').format(
                                          int.parse(widget.sneakers.price)),
                                      style: appStyle(
                                          26, Colors.black, FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Màu",
                                          style: appStyle(18, Colors.black,
                                              FontWeight.w500),
                                        ),
                                        SizedBox(width: 5),
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.black,
                                        ),
                                        SizedBox(width: 5),
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.amber,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Select sizes",
                                          style: appStyle(20, Colors.black,
                                              FontWeight.w600),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "View size guide",
                                          style: appStyle(
                                              20, Colors.grey, FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                          itemCount:
                                              productNotifier.shoeSizes.length,
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final sizes = productNotifier
                                                .shoeSizes[index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: ChoiceChip(
                                                showCheckmark: false,
                                                shape: CircleBorder(),
                                                disabledColor: Colors.white,
                                                label: Text(
                                                  sizes['size'],
                                                  style: appStyle(
                                                      16,
                                                      sizes['isSelected']
                                                          ? Colors.white
                                                          : Colors.black,
                                                      FontWeight.w500),
                                                ),
                                                selectedColor: Colors.black,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                selected: sizes['isSelected'],
                                                onSelected: (newState) {
                                                  if (productNotifier.sizes
                                                      .contains(
                                                          sizes['size'])) {
                                                    productNotifier.sizes
                                                        .remove(sizes['size']);
                                                  } else {
                                                    productNotifier.sizes
                                                        .add(sizes['size']);
                                                  }
                                                  productNotifier
                                                      .toggleCheck(index);
                                                },
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider(
                                  indent: 10,
                                  endIndent: 10,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    widget.sneakers.title,
                                    style: appStyle(
                                        20, Colors.black, FontWeight.w700),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  widget.sneakers.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 4,
                                  style: appStyle(
                                      14, Colors.black, FontWeight.normal),
                                ),
                                SizedBox(height: 10),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 12),
                                    child: CheckoutButton(
                                      label: "Thêm giỏ hàng",
                                      onTap: () async {
                                        if (authNotifier.loggeIn == true) {
                                          AddToCart model = AddToCart(
                                              cartItem: widget.sneakers.id,
                                              quantity: 1);
                                          CartHelper().addToCart(model);

                                          Navigator.pop(context);
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        }
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
        ],
      );
    }));
  }
}
