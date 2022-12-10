import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmshoppy/provider/feturedItem_provider.dart';
import 'package:provider/provider.dart';
import '../models/feturedItem_model.dart';
import '../resources/app_utils.dart';
import '../resources/colors.dart';
import '../resources/constatnts.dart';
import '../services/dioHelper.dart';

class ProductDetails extends StatefulWidget {
  final ItemModel model;
  final bool fromCart;
  //final String urlKey;

  const ProductDetails({Key? key, this.fromCart = false, required this.model})
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
    await DioHelper().getProductDetails(context, widget.model.urlKey);
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
                            const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black,
                            )
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
                            // Consumer<CartProvider>(builder: (context, model, _) {
                            //   if (widget.model.salesPrice == 0.0) {
                            //     return const SizedBox();
                            //   } else if (widget.model.stock == 0.0) {
                            //     return Text(
                            //       'Out Of Stock',
                            //       style: GoogleFonts.nunitoSans(
                            //           color: primaryRed,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w500),
                            //     );
                            //   } else {
                            //     return model.cartList.any((element) =>
                            //     element.itemID == widget.model.itemID)
                            //         ? Container(
                            //       // width: 100,
                            //       margin:
                            //       EdgeInsets.symmetric(horizontal: 15),
                            //       // padding: EdgeInsets.symmetric(
                            //       //     horizontal: 15, vertical: 5),
                            //       decoration: BoxDecoration(
                            //           border: Border.all(color: greyColor),
                            //           borderRadius:
                            //           BorderRadius.circular(20)),
                            //       child: Row(
                            //         mainAxisSize: MainAxisSize.min,
                            //         mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           SizedBox(
                            //             height: 35,
                            //             width: 35,
                            //             child: IconButton(
                            //               icon: Image.asset(
                            //                 removeRed,
                            //               ),
                            //               onPressed: () async {
                            //                 // if (quantity > 0) {
                            //                 //   setState(() {
                            //                 //     quantity--;
                            //                 //   });
                            //                 // }
                            //                 if (model.cartList
                            //                     .firstWhere((element) =>
                            //                 element.itemID ==
                            //                     widget.model.itemID)
                            //                     .quantity >
                            //                     1) {
                            //                   setState(() {
                            //                     quantity--;
                            //                   });
                            //                   dbHelper.updateCart(CartModel(
                            //                     branchId: 1,
                            //                     itemID:
                            //                     widget.model.itemID!,
                            //                     itemName:
                            //                     widget.model.itemName!,
                            //                     itemUnit:
                            //                     widget.model.unit!,
                            //                     imageUrl:
                            //                     widget.model.image!,
                            //                     barcode:
                            //                     widget.model.barcode!,
                            //                     quantity: model.cartList
                            //                         .firstWhere(
                            //                             (element) =>
                            //                         element
                            //                             .itemID ==
                            //                             widget.model
                            //                                 .itemID)
                            //                         .quantity -
                            //                         1,
                            //                     salesPrice: widget
                            //                         .model.salesPrice
                            //                         ?.toDouble(),
                            //                     mrP: widget.model.mrp!
                            //                         .toDouble(),
                            //                   ));
                            //                 } else {
                            //                   dbHelper.deleteCartItem(
                            //                       widget.model.itemID);
                            //                 }
                            //                 await model.getCart(context);
                            //               },
                            //             ),
                            //           ),
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 8.0),
                            //             child: Text(
                            //               '${model.cartList.firstWhere((element) => element.itemID == widget.model.itemID).quantity}',
                            //               style: GoogleFonts.nunitoSans(
                            //                   fontWeight: FontWeight.w700,
                            //                   fontSize: 16),
                            //             ),
                            //           ),
                            //           SizedBox(
                            //             height: 35,
                            //             width: 35,
                            //             child: IconButton(
                            //               icon: Image.asset(
                            //                 addRed,
                            //               ),
                            //               onPressed: () async {
                            //                 // setState(() {
                            //                 //   quantity++;
                            //                 // });
                            //                 dbHelper.updateCart(CartModel(
                            //                   itemID: widget.model.itemID!,
                            //                   itemName:
                            //                   widget.model.itemName!,
                            //                   itemUnit: widget.model.unit!,
                            //                   imageUrl: widget.model.image!,
                            //                   barcode:
                            //                   widget.model.barcode!,
                            //                   quantity: model.cartList
                            //                       .firstWhere(
                            //                           (element) =>
                            //                       element
                            //                           .itemID ==
                            //                           widget.model
                            //                               .itemID!)
                            //                       .quantity +
                            //                       1,
                            //                   salesPrice: widget
                            //                       .model.salesPrice!
                            //                       .toDouble(),
                            //                   mrP: widget.model.mrp!
                            //                       .toDouble(),
                            //                   branchId: 1,
                            //                 ));
                            //                 await model.getCart(context);
                            //               },
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     )
                            //         : InkWell(
                            //         onTap: () async {
                            //           dbHelper.insert(CartModel(
                            //             itemID: widget.model.itemID!,
                            //             itemName: widget.model.itemName!,
                            //             itemUnit: widget.model.unit!,
                            //             imageUrl: widget.model.image!,
                            //             barcode: widget.model.barcode!,
                            //             quantity: 1,
                            //             salesPrice: widget.model.salesPrice!
                            //                 .toDouble(),
                            //             mrP: widget.model.mrp!.toDouble(),
                            //             branchId: 1,
                            //           ));
                            //           await model.getCart(context);
                            //           setState(() {
                            //             quantity = 1;
                            //           });
                            //         },
                            //         child: Container(
                            //           width: 100,
                            //           margin: EdgeInsets.symmetric(
                            //               horizontal: 15),
                            //           padding: EdgeInsets.symmetric(
                            //               horizontal: 15, vertical: 5),
                            //           decoration: BoxDecoration(
                            //               border:
                            //               Border.all(color: greyColor),
                            //               borderRadius:
                            //               BorderRadius.circular(20)),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //             MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               Text(
                            //                 'Add',
                            //                 style: GoogleFonts.nunitoSans(
                            //                     color: Colors.black,
                            //                     fontSize: 16,
                            //                     fontWeight: FontWeight.w700),
                            //               ),
                            //               Image.asset(
                            //                 addRed,
                            //                 width: 20,
                            //               )
                            //             ],
                            //           ),
                            //         ));
                            //   }
                            // }),
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.redAccent,
                                            // border:
                                            //     Border.all(color: greyColor),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            'Add',
                                            style: GoogleFonts.nunitoSans(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      )),
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
                                                                    .redAccent,
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
                    ],
                  );
                }),
              ),
      ),
    );
  }
}
