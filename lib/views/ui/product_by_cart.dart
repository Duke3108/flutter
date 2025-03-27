import 'package:duke_shoes_shop/controllers/product_provider.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/category_btn.dart';
import 'package:duke_shoes_shop/views/shared/customer_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../shared/grid_product.dart';

class ProdcutByCat extends StatefulWidget {
  const ProdcutByCat({super.key, required this.tabIndex});

  final int tabIndex;

  @override
  State<ProdcutByCat> createState() => _ProdcutByCatState();
}

class _ProdcutByCatState extends State<ProdcutByCat>
    with TickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKid();
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                      padding: EdgeInsets.zero,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Colors.white,
                      labelStyle: appStyle(24, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: const [
                        Tab(text: "Giày Nam"),
                        Tab(text: "Giày Nữ"),
                        Tab(text: "Giày Trẻ Em"),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: TabBarView(controller: _tabController, children: [
                  GridProduct(male: productNotifier.male),
                  GridProduct(male: productNotifier.female),
                  GridProduct(male: productNotifier.kid),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> filter() {
    double _value = 100;
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        context: context,
        builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.84,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        CustomerSpacer(),
                        Text(
                          "Bộ lọc",
                          style: appStyle(40, Colors.black, FontWeight.bold),
                        ),
                        CustomerSpacer(),
                        Text(
                          "Giới tính",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CategoryBtn(buttonClr: Colors.black, label: "Nam"),
                            CategoryBtn(buttonClr: Colors.grey, label: "Nữ"),
                            CategoryBtn(
                                buttonClr: Colors.grey, label: "Trẻ em"),
                          ],
                        ),
                        CustomerSpacer(),
                        Text(
                          "Phân loại",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CategoryBtn(buttonClr: Colors.black, label: "Giày"),
                            CategoryBtn(
                                buttonClr: Colors.grey, label: "May mặc"),
                            CategoryBtn(
                                buttonClr: Colors.grey, label: "Phụ kiện"),
                          ],
                        ),
                        CustomerSpacer(),
                        Text(
                          "Giá",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        CustomerSpacer(),
                        Slider(
                            value: _value,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.black,
                            max: 500,
                            divisions: 50,
                            label: _value.toString(),
                            secondaryTrackValue: 200,
                            onChanged: (double value) {}),
                        CustomerSpacer(),
                        Text(
                          "Nhà sản xuất",
                          style: appStyle(20, Colors.black, FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 80,
                          child: ListView.builder(
                              itemCount: brand.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: Image.asset(
                                      brand[index],
                                      height: 60,
                                      width: 80,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
