import 'package:cached_network_image/cached_network_image.dart';
import 'package:duke_shoes_shop/controllers/product_provider.dart';
import 'package:duke_shoes_shop/models/sneaker_model.dart';
import 'package:duke_shoes_shop/services/helper.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/custom_field.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:duke_shoes_shop/views/ui/productpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

String formatPrice(String price) {
  int value = int.tryParse(price.replaceAll(',', '')) ?? 0;
  return NumberFormat('#,###').format(value * 100);
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100.h,
          backgroundColor: Colors.black,
          elevation: 0,
          title: CustomField(
            controller: search,
            hintText: "Tìm kiếm sản phẩm",
            onEditingComplete: () {
              setState(() {});
            },
            prefixIcon: GestureDetector(
              onTap: () {},
              child: Icon(
                AntDesign.camera,
                color: Colors.black,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Icon(
                AntDesign.search1,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: search.text.isEmpty
            ? Container(
                height: 600.h,
                child: Image.asset(
                  'assets/images/search_hover.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              )
            : FutureBuilder<List<Sneakers>>(
                future: Helper().search(search.text),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: reusableText(
                          text: 'Lỗi lấy dữ liệu',
                          style: appStyle(20, Colors.black, FontWeight.bold)),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: reusableText(
                          text: 'Không tìm thấy sản phẩm',
                          style: appStyle(20, Colors.black, FontWeight.bold)),
                    );
                  } else {
                    final shoes = snapshot.data;
                    return ListView.builder(
                        itemCount: shoes!.length,
                        itemBuilder: (context, index) {
                          final shoe = shoes[index];
                          return GestureDetector(
                            onTap: () {
                              productNotifier.shoesSizes = shoe.sizes;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(sneakers: shoe)));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(4.h),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                child: Container(
                                  height: 100.h,
                                  width: 325,
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
                                            padding: EdgeInsets.all(12.h),
                                            child: CachedNetworkImage(
                                              imageUrl: shoe.imageUrl[0],
                                              width: 70.w,
                                              height: 70.h,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 12.h, left: 10.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                reusableText(
                                                    text: shoe.name,
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.w600)),
                                                SizedBox(height: 5.h),
                                                reusableText(
                                                    text: shoe.category,
                                                    style: appStyle(
                                                        13,
                                                        Colors.grey.shade600,
                                                        FontWeight.w600)),
                                                SizedBox(height: 5.h),
                                                reusableText(
                                                    text:
                                                        formatPrice(shoe.price),
                                                    style: appStyle(
                                                        13,
                                                        Colors.black,
                                                        FontWeight.w600))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                }));
  }
}
