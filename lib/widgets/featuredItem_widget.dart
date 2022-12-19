import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kmshoppy/resources/urls.dart';
import 'package:provider/provider.dart';

import '../models/feturedItem_model.dart';
import '../resources/app_utils.dart';
import '../resources/colors.dart';
import '../resources/constatnts.dart';

class FrequentItemBlock extends StatefulWidget {
  final ItemModel data;

  const FrequentItemBlock({Key? key, required this.data}) : super(key: key);

  @override
  State<FrequentItemBlock> createState() => _FrequentItemBlockState();
}

class _FrequentItemBlockState extends State<FrequentItemBlock> {
  int quantity = 0;
  //DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Card(
              elevation: 10,
              shadowColor: Colors.blue[50],
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                width: MediaQuery.of(context).size.width / 3.4,
                //height: MediaQuery.of(context).size.height/4,
                //height: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //height: 90,
                      height: MediaQuery.of(context).size.height / 10,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: CachedNetworkImage(
                            imageUrl: "$mediaUrl${widget.data.image!}",
                            fit: BoxFit.cover,
                            // placeholder: (ctx, url) => Center(
                            //   child: appLoading(),
                            // ),
                            progressIndicatorBuilder: (ctx, url, progress) =>
                                Center(
                                  child: appLoading(value: progress.progress),
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image)
                            //     Image.asset(
                            //   noImage,
                            //   // width: 80,
                            // ),
                            ),
                      ),
                    ),
                    Text(
                      widget.data.itemName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w700, fontSize: 11),
                    ),
                    Text(
                        rupeeSymbol +
                            (widget.data.salesPrice! + 5).toStringAsFixed(2),
                        style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: greyColor,
                            decoration: TextDecoration.lineThrough)),
                    Text(
                      '₹${widget.data.salesPrice!.toStringAsFixed(2)}',
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '1 Pack',
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w900,
                            fontSize: 12
                          ),
                        ),
                        Card(
                          elevation: 4,
                          child: Icon(Icons.add, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Icon(Icons.favorite_outline_sharp, color: Colors.red[200],size: 20,),
        ),
        // Image.asset("lib/images/discountsheet.jpg",height: 40,)
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                image:  DecorationImage(
                  image:  AssetImage("lib/images/discountsheet.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '3%',
                      style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Off',
                      style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            )),

        // Consumer<CartProvider>(builder: (context, model, _) {
        //  return Positioned(
        //    right: 0,
        //    child: model.cartList
        //        .any((element) => element.itemID == widget.data.itemID)
        //        ? SizedBox(
        //      // height: 50,
        //      // width: 150,
        //      child: Card(
        //        shape: RoundedRectangleBorder(
        //            borderRadius: BorderRadius.circular(25.0)),
        //        child: Padding(
        //          padding: const EdgeInsets.symmetric(horizontal: 10),
        //          child: Row(
        //            mainAxisSize: MainAxisSize.min,
        //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //            children: [
        //              IconButton(
        //                icon: Image.asset(
        //                  removeRed,
        //                  height: 18,
        //                ),
        //                onPressed: () async {
        //                  if (model.cartList
        //                      .firstWhere((element) =>
        //                  element.itemID ==
        //                      widget.data.itemID)
        //                      .quantity >
        //                      1) {
        //                    dbHelper.updateCart(CartModel(
        //                      branchId: 1,
        //                      itemID: widget.data.itemID!,
        //                      itemName: widget.data.itemName!,
        //                      itemUnit: widget.data.unit!,
        //                      imageUrl: widget.data.image!,
        //                      barcode: widget.data.barcode!,
        //                      quantity: model.cartList
        //                          .firstWhere((element) =>
        //                      element.itemID ==
        //                          widget.data.itemID)
        //                          .quantity -
        //                          1,
        //                      salesPrice:
        //                      widget.data.salesPrice?.toDouble(),
        //                      mrP: widget.data.mrp!.toDouble(),
        //                    ));
        //                  } else {
        //                    dbHelper.deleteCartItem(widget.data.itemID);
        //                  }
        //                  await model.getCart(context);
        //                  // if (quantity > 0) {
        //                  //   setState(() {
        //                  //     quantity--;
        //                  //   });
        //                  // }
        //                },
        //              ),
        //              Text(
        //                '${model.cartList.firstWhere((element) => element.itemID == widget.data.itemID).quantity}',
        //                style: GoogleFonts.nunitoSans(
        //                    fontWeight: FontWeight.w700, fontSize: 18),
        //              ),
        //              IconButton(
        //                icon: Image.asset(
        //                  addRed,
        //                  height: 20,
        //                ),
        //                onPressed: () async {
        //                  // setState(() {
        //                  //   quantity++;
        //                  // });
        //                  dbHelper.updateCart(CartModel(
        //                    itemID: widget.data.itemID!,
        //                    itemName: widget.data.itemName!,
        //                    itemUnit: widget.data.unit!,
        //                    imageUrl: widget.data.image!,
        //                    barcode: widget.data.barcode!,
        //                    quantity: model.cartList
        //                        .firstWhere((element) =>
        //                    element.itemID ==
        //                        widget.data.itemID)
        //                        .quantity +
        //                        1,
        //                    salesPrice:
        //                    widget.data.salesPrice!.toDouble(),
        //                    mrP: widget.data.mrp!.toDouble(),
        //                    branchId: 1,
        //                  ));
        //                  await model.getCart(context);
        //                },
        //              ),
        //            ],
        //          ),
        //        ),
        //      ),
        //    )
        //        : IconButton(
        //      onPressed: () async {
        //        dbHelper.insert(CartModel(
        //          itemID: widget.data.itemID!,
        //          itemName: widget.data.itemName!,
        //          itemUnit: widget.data.unit!,
        //          imageUrl: widget.data.image!,
        //          barcode: widget.data.barcode!,
        //          quantity: 1,
        //          salesPrice: widget.data.salesPrice!.toDouble(),
        //          mrP: widget.data.mrp!.toDouble(),
        //          branchId: 1,
        //        ));
        //        await model.getCart(context);
        //        // setState(() {
        //        //   quantity = 1;
        //        // });
        //      },
        //      icon: Container(
        //        padding: EdgeInsets.all(5),
        //        decoration: BoxDecoration(
        //            color: primaryRed, shape: BoxShape.circle),
        //        child: Center(
        //          child: Image.asset(addWhite),
        //        ),
        //      ),
        //    ),
        //  );
        // })
      ],
    );
  }
}
