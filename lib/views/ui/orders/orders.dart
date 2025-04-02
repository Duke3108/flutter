import 'package:duke_shoes_shop/services/carthelper.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../../../models/order/orders_res.dart';

class ProcessOrders extends StatefulWidget {
  const ProcessOrders({super.key});

  @override
  State<ProcessOrders> createState() => _ProcessOrdersState();
}

String formatPrice(String price) {
  int value = int.tryParse(price.replaceAll(',', '')) ?? 0;
  return NumberFormat('#,###').format(value * 100);
}

class _ProcessOrdersState extends State<ProcessOrders> {
  Future<List<PaidOrders>>? _orders;

  @override
  void initState() {
    super.initState();
    _orders = CartHelper().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.h,
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            AntDesign.left,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 825.h,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText(
                    text: "Giỏ hàng",
                    style: appStyle(36, Colors.white, FontWeight.bold)),
                SizedBox(height: 5.h),
                Container(
                  height: 650.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.white),
                  child: FutureBuilder<List<PaidOrders>>(
                    future: _orders,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: reusableText(
                              text: "không thế lấy dữ liệu đơn hàng",
                              style:
                                  appStyle(18, Colors.black, FontWeight.w600)),
                        );
                      } else {
                        final products = snapshot.data;
                        return ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            var order = products[index];
                            return Container(
                              margin: EdgeInsets.all(9),
                              padding: EdgeInsets.all(8),
                              height: 75.h,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Padding(
                                          padding: EdgeInsets.all(.0),
                                          child: Image.network(
                                              order.productId.imageUrl[0]),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: FittedBox(
                                              child: reusableText(
                                                  text: order.productId.name,
                                                  style: appStyle(
                                                      12,
                                                      Colors.black,
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: FittedBox(
                                              child: reusableText(
                                                  text: order.productId.title,
                                                  style: appStyle(
                                                      12,
                                                      Colors.grey.shade700,
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          reusableText(
                                              text: formatPrice(
                                                  order.productId.price),
                                              style: appStyle(
                                                  12,
                                                  Colors.grey.shade600,
                                                  FontWeight.w600)),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: reusableText(
                                            text: order.paymentStatus
                                                .toUpperCase(),
                                            style: appStyle(12, Colors.white,
                                                FontWeight.w600)),
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            MaterialCommunityIcons
                                                .truck_fast_outline,
                                            size: 16,
                                          ),
                                          SizedBox(width: 5.w),
                                          reusableText(
                                              text: order.deliveryStatus
                                                  .toUpperCase(),
                                              style: appStyle(12, Colors.black,
                                                  FontWeight.w500)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
