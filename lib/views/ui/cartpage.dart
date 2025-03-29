import 'package:cached_network_image/cached_network_image.dart';
import 'package:duke_shoes_shop/controllers/cart_provider.dart';
import 'package:duke_shoes_shop/controllers/payment_provider.dart';
import 'package:duke_shoes_shop/models/order/orders_req.dart';
import 'package:duke_shoes_shop/services/carthelper.dart';
import 'package:duke_shoes_shop/services/paymenthelper.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/checkout_btn.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/ui/mainscreen.dart';
import 'package:duke_shoes_shop/views/ui/payment/paymentview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart/get_products.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cart = [];

  late Future<List<Product>> _cartList;

  @override
  void initState() {
    _cartList = CartHelper().getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    var paymentNotifier = Provider.of<PaymentNotifier>(context);
    cartProvider.getCart();
    return paymentNotifier.paymentUrl.contains('https')
        ? const PaymentView()
        : Scaffold(
            backgroundColor: const Color(0xFFE2E2E2),
            body: Padding(
              padding: EdgeInsets.all(12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          AntDesign.close,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Giỏ Hàng",
                        style: appStyle(36, Colors.black, FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.65,
                        child: FutureBuilder(
                            future: _cartList,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: reusableText(
                                      text: "không thế lấy dữ liệu giỏ hàng",
                                      style: appStyle(
                                          18, Colors.black, FontWeight.w600)),
                                );
                              } else {
                                final cartData = snapshot.data;
                                return ListView.builder(
                                    itemCount: cartData!.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final data = cartData[index];
                                      return GestureDetector(
                                        onTap: () {
                                          cartProvider.setProductIndex = index;
                                          cartProvider.checkout.insert(0, data);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.11,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors
                                                            .grey.shade500,
                                                        spreadRadius: 5,
                                                        blurRadius: 0.3,
                                                        offset: Offset(0, 1))
                                                  ]),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    12),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: data
                                                                  .cartItem
                                                                  .imageUrl[0],
                                                              width: 70,
                                                              height: 70,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                          Positioned(
                                                              left: 2,
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  cartProvider
                                                                          .setProductIndex =
                                                                      index;
                                                                },
                                                                child: SizedBox(
                                                                  height: 30.h,
                                                                  width: 30.w,
                                                                  child: Icon(
                                                                    cartProvider.productIndex ==
                                                                            index
                                                                        ? Feather
                                                                            .check_square
                                                                        : Feather
                                                                            .square,
                                                                    size: 22,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              )),
                                                          Positioned(
                                                              bottom: -4,
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await CartHelper()
                                                                      .deleteItem(
                                                                          data
                                                                              .id)
                                                                      .then(
                                                                          (response) {
                                                                    if (response ==
                                                                        true) {
                                                                      Navigator.pushReplacement(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => MainScreen()));
                                                                    } else {
                                                                      debugPrint(
                                                                          "Không thể xóa sản phẩm");
                                                                    }
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: 40,
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .black,
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                              topRight: Radius.circular(12))),
                                                                  child: Icon(
                                                                    AntDesign
                                                                        .delete,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12,
                                                                left: 12),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            reusableText(
                                                              text: data
                                                                          .cartItem
                                                                          .name
                                                                          .length >
                                                                      20
                                                                  ? '${data.cartItem.name.substring(0, 20)}...'
                                                                  : data
                                                                      .cartItem
                                                                      .name,
                                                              style: appStyle(
                                                                  16,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Text(
                                                              data.cartItem
                                                                  .category,
                                                              style: appStyle(
                                                                  14,
                                                                  Colors.grey,
                                                                  FontWeight
                                                                      .w600),
                                                            ),
                                                            SizedBox(height: 5),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  NumberFormat(
                                                                          '###,###.###')
                                                                      .format(int.parse(data
                                                                          .cartItem
                                                                          .price)),
                                                                  style: appStyle(
                                                                      18,
                                                                      Colors
                                                                          .black,
                                                                      FontWeight
                                                                          .w600),
                                                                ),
                                                                SizedBox(
                                                                    width: 30),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          16))),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {},
                                                                child: Icon(
                                                                  AntDesign
                                                                      .minussquare,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                              Text(
                                                                data.quantity
                                                                    .toString(),
                                                                style: appStyle(
                                                                    16,
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .w600),
                                                              ),
                                                              InkWell(
                                                                onTap: () {},
                                                                child: Icon(
                                                                  AntDesign
                                                                      .plussquare,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            }),
                      )
                    ],
                  ),
                  cartProvider.checkout.isNotEmpty
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: CheckoutButton(
                            onTap: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? userId = prefs.getString('userId') ?? "";
                              Order model = Order(userId: userId, cartItems: [
                                CartItem(
                                    name:
                                        cartProvider.checkout[0].cartItem.name,
                                    id: cartProvider.checkout[0].cartItem.id,
                                    price:
                                        cartProvider.checkout[0].cartItem.price,
                                    cartQuantity: 1)
                              ]);

                              PaymentHelper().payment(model).then((value) {
                                paymentNotifier.setPaymentUrl = value;
                                print(paymentNotifier.paymentUrl);
                              });
                            },
                            label: "Thanh Toán",
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ),
          );
  }
}
