import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmshoppy/models/cart_model.dart';
import 'package:kmshoppy/provider/feturedItem_provider.dart';
import 'package:provider/provider.dart';
import '../db/db_functions.dart';
import '../db/db_model.dart';
import '../models/feturedItem_model.dart';
import '../provider/cart_provider.dart';
import '../resources/app_utils.dart';
import '../resources/colors.dart';
import '../resources/constatnts.dart';
import '../services/dioHelper.dart';
import '../widgets/featured_items.dart';
import 'cart/my_cart.dart';

class ProductDetails extends StatefulWidget {
 // final ItemModel model;
  final bool fromCart;
  final String urlKey;
  final int itemId;

  const ProductDetails({Key? key, this.fromCart = false,  required this.urlKey, required this.itemId})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  //DbHelper dbHelper = DbHelper();
  bool isFavourite = false;
  int activeIndex = 0;
  int quantity = 0;
  bool isLoading = false;

  getFavouriteStatus() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    await DioHelper().getProductDetails(context, widget.urlKey);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Center(
                child: appLoading(),
              )
            : SingleChildScrollView(
                child: Consumer<ItemProvider>(builder: (context, model, _) {
                  // print("name=${model.productDetail.variants}");
                  // print("length=${model.productDetail.variantList?.length ?? 0}");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 20, left: 5, right: 20),
                        child: Row(
                          children: [
                            IconButton(
                              //icon: Image.asset(backIcon),
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.search_rounded,
                              color: Colors.black,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ValueListenableBuilder(
                                valueListenable: cartListNotifier,
                                builder: (BuildContext ctx,
                                    List<DbCartModel> cartList, Widget? child) {
                                  int iconCount = cartList.length;
                                  return Badge(
                                      // position: BadgePosition(top: 0,bottom: 8),
                                      //showBadge: true,
                                      showBadge: iconCount == 0 ? false : true,
                                      badgeColor: Colors.red[500]!,
                                      badgeContent: Text(
                                        iconCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      child: IconButton(
                                          onPressed: () {
                                            if(widget.fromCart){
                                              Navigator.pop(context);
                                            }else{
                                              navigateToPage(
                                                  context,
                                                  const MyCart(
                                                    inDetail: true,
                                                  ));
                                            }

                                          },
                                          icon: const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.black,
                                          )));
                                }),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.all(20.0),
                              // width: MediaQuery.of(context).size.height/3,
                              //height: MediaQuery.of(context).size.height/3,
                              //height: 250,
                              child: Center(
                                child: buildNetworkImage(
                                    context, model.productDetail.image,
                                    boxFit: BoxFit.cover),
                              )
                              // child: Image.network(widget.model.image!,fit: BoxFit.cover,),
                              ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Icon(
                              Icons.favorite_outline_sharp,
                              color: Colors.red[200],
                              size: 25,
                            ),
                          ),
                          const Positioned(
                            bottom: 15,
                            right: 15,
                            child: Icon(
                              Icons.zoom_out_map,
                              color: greyColor,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          model.productDetail.itemName ?? "",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w800, fontSize: 19),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Text(
                          '1 Pack',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    rupeeSymbol +
                                        model.productDetail.unitPrice!
                                            .toStringAsFixed(2),
                                    style: GoogleFonts.nunitoSans(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 19)),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            //quantity == 0,
                          ],
                        ),
                      ),
                      model.productDetail.variantList!.isEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(
                                  //     width: 2,
                                  //     color: Colors.indigo),
                                  borderRadius: BorderRadius.circular(5)),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  rupeeSymbol +
                                                      model.productDetail
                                                          .unitPrice!
                                                          .toStringAsFixed(2),
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14)),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  rupeeSymbol +
                                                      // (model.productDetail.specialPrice!+5)
                                                      model.productDetail
                                                          .unitPrice!
                                                          .toStringAsFixed(2),
                                                  style: GoogleFonts.nunitoSans(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                      color: greyColor,
                                                      decoration: TextDecoration
                                                          .lineThrough)),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.indigo,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0)),
                                                //height: 65,
                                                //width: 65,
                                                child: Center(
                                                  child: Text(
                                                    '4 % OFF',
                                                    //'${getDiscount(widget.model.salesPrice!, widget.model.mrp!)}% OFF',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.nunitoSans(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 11),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: cartListNotifier,
                                      builder: (BuildContext ctx,
                                          List<DbCartModel> cartList,
                                          Widget? child) {
                                        return cartList.any((element) =>
                                                element.itemID ==
                                                widget.itemId)
                                            ? Container(
                                                // width: 100,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                // padding: EdgeInsets.symmetric(
                                                //     horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.pink,
                                                    // border: Border.all(
                                                    //     color: greyColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 35,
                                                      width: 35,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () async {
                                                          final int index =
                                                              cartList.indexWhere(
                                                                  (element) =>
                                                                      element
                                                                          .itemID ==
                                                                      widget.itemId,
                                                                  0);
                                                          final data =
                                                              cartList[index];
                                                          print("index=$index");
                                                          if (cartList
                                                                  .firstWhere((element) =>
                                                                      element
                                                                          .itemID ==
                                                                      widget
                                                                          .itemId)
                                                                  .quantity >
                                                              1) {
                                                            setState(() {
                                                              quantity--;
                                                            });
                                                            updateCartItem(
                                                                DbCartModel(
                                                              keyId:
                                                                  data.keyId!,
                                                              itemName: model
                                                                  .productDetail
                                                                  .itemName!,
                                                              imageUrl: model
                                                                  .productDetail
                                                                  .image!,
                                                              unitPrice: model
                                                                  .productDetail
                                                                  .unitPrice!,
                                                              itemID: model
                                                                  .productDetail
                                                                  .itemID!,
                                                              specialPrice: model
                                                                  .productDetail
                                                                  .specialPrice!,
                                                              quantity: cartList
                                                                      .firstWhere((element) =>
                                                                          element
                                                                              .itemID ==
                                                                          widget.itemId)
                                                                      .quantity -
                                                                  1,
                                                                  urlKey: model
                                                                      .productDetail.urlKey!,
                                                            ));
                                                          } else {
                                                            if (data.keyId !=
                                                                null) {
                                                              removeItem(
                                                                  data.keyId!);
                                                              //allClear();
                                                              print(
                                                                  "delete success");
                                                            } else {
                                                              print(
                                                                  "id is null");
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        '${cartList.firstWhere((element) => element.itemID == widget.itemId).quantity}',
                                                        style: GoogleFonts
                                                            .nunitoSans(
                                                          color: Colors.white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 35,
                                                      width: 35,
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.add,
                                                            color: Colors.white),
                                                        onPressed: () async {
                                                          final int index =
                                                              cartList.indexWhere(
                                                                  (element) =>
                                                                      element
                                                                          .itemID ==
                                                                      widget.itemId,
                                                                  0);
                                                          final data =
                                                              cartList[index];
                                                          print("index=$index");
                                                          setState(() {
                                                            quantity++;
                                                          });
                                                          updateCartItem(
                                                              DbCartModel(
                                                            keyId: data.keyId!,
                                                            itemName: model
                                                                .productDetail
                                                                .itemName!,
                                                            imageUrl: model
                                                                .productDetail
                                                                .image!,
                                                            unitPrice: model
                                                                .productDetail
                                                                .unitPrice!,
                                                            itemID: model
                                                                .productDetail
                                                                .itemID!,
                                                            specialPrice: model
                                                                .productDetail
                                                                .specialPrice!,
                                                            quantity: cartList
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .itemID ==
                                                                        widget.itemId)
                                                                    .quantity +
                                                                1,
                                                                urlKey: model
                                                                    .productDetail.urlKey!,
                                                          ));

                                                          // await model.getCart(context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  addItem(DbCartModel(
                                                      itemName: model
                                                          .productDetail
                                                          .itemName!,
                                                      imageUrl: model
                                                          .productDetail.image!,
                                                      unitPrice: model
                                                          .productDetail
                                                          .unitPrice!,
                                                      itemID: model
                                                          .productDetail
                                                          .itemID!,
                                                      specialPrice: model
                                                          .productDetail
                                                          .specialPrice!,
                                                      quantity: 1,
                                                    urlKey: model
                                                        .productDetail.urlKey!,));
                                                  //await model.getCart(context);
                                                  setState(() {
                                                    quantity = 1;
                                                  });
                                                },
                                                child: Container(
                                                  width: 100,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.pink,
                                                      // border:
                                                      // Border.all(color: greyColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text(
                                                      'Add',
                                                      style: GoogleFonts
                                                          .nunitoSans(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ),
                                                ));
                                      }),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                //height: 200,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    // border: Border.all(
                                    //     color:
                                    //     Color.fromRGBO(211, 211, 207, 1)),
                                    borderRadius: BorderRadius.circular(12)),
                                //height: 50,
                                //margin: const EdgeInsets.symmetric(vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Text(
                                        'Please select a variant',
                                        style: GoogleFonts.nunitoSans(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                            color: Colors.black),
                                      ),
                                    ),
                                    ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: model
                                            .productDetail.variantList!.length,
                                        itemBuilder: (ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              // navigateToPage(context,
                                              //     ProductDetails(model: randomList[index],));
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 2,
                                                      color: Colors.indigo),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.7,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          //model.productDetail.variants?.first.itemName ?? "error",
                                                          model
                                                                  .productDetail
                                                                  .variantList![
                                                                      index]
                                                                  .itemName ??
                                                              "No name",
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 15),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  rupeeSymbol +
                                                                      model
                                                                          .productDetail
                                                                          .variantList![
                                                                              index]
                                                                          .specialPrice!
                                                                          .toStringAsFixed(
                                                                              2),
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          14)),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  rupeeSymbol +
                                                                      // (model.productDetail.specialPrice!+5)
                                                                      model
                                                                          .productDetail
                                                                          .variantList![
                                                                              index]
                                                                          .unitPrice!
                                                                          .toStringAsFixed(
                                                                              2),
                                                                  style: GoogleFonts.nunitoSans(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          13,
                                                                      color:
                                                                          greyColor,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough)),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        5),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .indigo,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0)),
                                                                //height: 65,
                                                                //width: 65,
                                                                child: Center(
                                                                  child: Text(
                                                                    '4 % OFF',
                                                                    //'${getDiscount(widget.model.salesPrice!, widget.model.mrp!)}% OFF',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: GoogleFonts.nunitoSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        fontSize:
                                                                            11),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        // dbHelper.insert(CartModel(
                                                        //   itemID: widget.model.itemID!,
                                                        //   itemName: widget.model.itemName!,
                                                        //   itemUnit: widget.model.unit!,
                                                        //   imageUrl: widget.model.image!,
                                                        //   barcode: widget.model.barcode!,
                                                        //   quantity: 1,
                                                        //   salesPrice: widget.model.salesPrice!
                                                        //       .toDouble(),
                                                        //   mrP: widget.model.mrp!.toDouble(),
                                                        //   branchId: 1,
                                                        // ));
                                                        // await model.getCart(context);
                                                        // setState(() {
                                                        //   quantity = 1;
                                                        // });
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4.5,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 10),
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 3,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .pink,
                                                                // border:
                                                                //     Border.all(color: greyColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                        child: Center(
                                                          child: Text(
                                                            'Add',
                                                            style: GoogleFonts
                                                                .nunitoSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ),
                      ExpansionTile(
                        title: Text(
                          'About Product',
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                        iconColor: Colors.grey,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              model.productDetail.shortDescription!.toString(),
                              // model.productDetail.itemName ?? "",
                              style: GoogleFonts.nunitoSans(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Text(
                          //     model.productDetail.description != null &&
                          //             model.productDetail.description != ""
                          //         ? model.productDetail.description!
                          //         : "testDescription",
                          //     style: GoogleFonts.nunitoSans(
                          //         fontWeight: FontWeight.w700,
                          //         fontSize: 15,
                          //         color: greyColor),
                          //   ),
                          // ),
                        ],
                      ),
                      const FeaturedItems(title: 'You Might Also Like',inHome: false),
                    ],
                  );
                }),
              ),
      ),
    );
  }
}
