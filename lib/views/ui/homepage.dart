import 'package:duke_shoes_shop/controllers/favorite_provider.dart';
import 'package:duke_shoes_shop/controllers/product_provider.dart';
import 'package:duke_shoes_shop/views/shared/appstyle.dart';
import 'package:duke_shoes_shop/views/shared/home_widget.dart';
import 'package:duke_shoes_shop/views/shared/resusableText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    productNotifier.getMale();
    productNotifier.getFemale();
    productNotifier.getKid();

    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getFavoritess();

    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 40, 0, 0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/top_image.png"),
                        fit: BoxFit.cover)),
                child: Container(
                  padding: EdgeInsets.only(left: 8, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                        text: "Duke Shoes",
                        style: appStyleWithHt(
                          42,
                          Colors.white,
                          FontWeight.bold,
                          1.5,
                        ),
                      ),
                      reusableText(
                        text: "Collection",
                        style: appStyleWithHt(
                          42,
                          Colors.white,
                          FontWeight.bold,
                          1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                          padding: EdgeInsets.zero,
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle:
                              appStyle(32, Colors.white, FontWeight.bold),
                          unselectedLabelColor: Colors.grey.withOpacity(0.3),
                          tabs: const [
                            Tab(text: "Giày Nam"),
                            Tab(text: "Giày Nữ"),
                            Tab(text: "Giày Trẻ Em"),
                          ]),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.265),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: TabBarView(controller: _tabController, children: [
                    HomeWidget(tabIndex: 0, male: productNotifier.male),
                    HomeWidget(tabIndex: 1, male: productNotifier.female),
                    HomeWidget(tabIndex: 2, male: productNotifier.kid),
                  ]),
                ),
              )
            ],
          ),
        ));
  }
}
