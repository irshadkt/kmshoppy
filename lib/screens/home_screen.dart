import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmshoppy/provider/slider_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_utils.dart';
import '../resources/colors.dart';
import '../resources/colors.dart';
import '../services/dioHelper.dart';
import 'dart:math' as math;

import '../widgets/bottomNavigationBar_widget.dart';
import '../widgets/featured_items.dart';
import '../widgets/home_footer_widget.dart';
import '../widgets/sliderIndicator_widget.dart';
import '../widgets/slider_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int? maxLines = 1;
  bool expanded = false;
  Matrix4 transform = Matrix4.rotationY(math.pi);
  int activeIndex = 0;
  bool isLoading = false;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories();
  }

  getCategories() async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    await DioHelper().getFeaturedItems(context, 5);
    await DioHelper().getSliders(context);
    //await DioHelper().getCategories(context, 1);
    // await Provider.of<CartProvider>(context, listen: false).getCart(context);
    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<bool> pressBackAgain() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          pressBackAgain();
          return true;
        },
        child: SafeArea(
          child: isLoading
              ? Center(child: appLoading())
              : SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:const BoxDecoration(
                          color: Colors.indigo,
                          // border: Border(
                          //     bottom: BorderSide(color: primaryYellow))
                        ),
                        padding:
                          const  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                //color: Colors.green,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children:  [
                                       const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          'Choose Location',
                                          style: GoogleFonts.nunitoSans(
                                              color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: Colors.red,
                                         // size: 20,
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.favorite_outline_sharp,
                                      color: Colors.white60,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // navigateToPage(context, SearchPage())
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            const Color.fromRGBO(211, 211, 207, 1)),
                                    borderRadius: BorderRadius.circular(12)),
                                height: 50,
                                margin:const EdgeInsets.symmetric(vertical: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.search_rounded,
                                      color: greyColor,
                                      size: 25,
                                    ),
                                    Text(
                                      'Search for over 5000 products',
                                      style: GoogleFonts.nunitoSans(
                                          color: greyColor,fontSize: 15,fontWeight: FontWeight.w800),
                                    ),
                                    // Image.asset(searchIcon)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<SliderProvider>(builder: (context, model, _) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/5.2,
                          margin:const EdgeInsets.symmetric(vertical: 10),
                          child: CarouselSlider.builder(
                            itemCount: model.sliderList.length,
                            itemBuilder: (ctx, index, realIndex) {
                              final image = model.sliderList[index].image!;
                              return buildBannerImage(image, index);
                            },
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval:const Duration(seconds: 3),
                              onPageChanged: (index, reason) =>
                                  setState(() => activeIndex = index),
                              // height: 300
                            ),
                          ),
                        );
                      }),
                      Consumer<SliderProvider>(builder: (context, model, _) {
                        return buildIndicator(
                            activeIndex, model.sliderList);
                      }),
                      const FeaturedItems(),
                      const HomeFooter(),
                      // ShopByCategory(),
                      const SizedBox(
                        height: 0,
                      )
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: const BottomBarListWidget(),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}


