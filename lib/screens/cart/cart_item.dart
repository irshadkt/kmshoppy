import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../db/db_functions.dart';
import '../../db/db_model.dart';
import '../../models/cart_model.dart';
import '../../provider/cart_provider.dart';
import '../../resources/app_utils.dart';
import '../../resources/colors.dart';
import '../../resources/urls.dart';

class CartItem extends StatefulWidget {
  final DbCartModel model;

  const CartItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  //DbHelper dbHelper = DbHelper();

  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    print("keyId=${widget.model.keyId}");
    //print(widget.model.toMap());
    return Consumer<CartProvider>(builder: (context, model, _) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            // Image.asset('assets/images/veg.png'),
            Stack(
              children: [
                Container(
                  // child: widget.model.cartItem.image != null
                  child: widget.model.imageUrl != null
                      ? CachedNetworkImage(
                    imageUrl:"$mediaUrl${widget.model.imageUrl}",
                    width: 60,
                    progressIndicatorBuilder: (ctx, url, progress) =>
                        Center(
                          child: appLoading(value: progress.progress),
                        ),
                    // placeholder: (ctx, url) => Center(
                    //   child: appLoading(),
                    // ),
                    errorWidget: (context, url, error) => Icon(Icons.image),
                  )
                      : Icon(Icons.image),
                ),
                // if(getDiscount(widget.model.salesPrice!, widget.model.mrP!) != 0)Container(
                //   padding: EdgeInsets.all(5),
                //   decoration: BoxDecoration(
                //       color: primaryYellow,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(10),
                //         bottomRight: Radius.circular(10),
                //       )),
                //   height: 35,
                //   width: 35,
                //   child: Text(
                //     '${widget.model.unitPrice!}% OFF',
                //    // '${getDiscount(widget.model.salesPrice!, widget.model.mrP!)}% OFF',
                //     textAlign: TextAlign.center,
                //     style: GoogleFonts.nunitoSans(
                //         fontWeight: FontWeight.w700, fontSize: 9),
                //   ),
                // ),
              ],
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.model.itemName,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 11,
                            fontWeight: FontWeight.w800)),
                    // Text(widget.model.itemUnit,
                    //     style: GoogleFonts.nunitoSans(
                    //         fontWeight: FontWeight.w400, color: greyColor)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              // width: 100,
              // height: 50,
              // padding:
              //     EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.pink,
                 // border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.remove,color:Colors.white),
                      onPressed: () async {
                        if (widget.model.quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                          updateCartItem(DbCartModel(
                            keyId:  widget.model.keyId!,
                            itemName: widget.model.itemName,
                            imageUrl: widget.model.imageUrl,
                            unitPrice: widget.model.unitPrice,
                            itemID: widget.model.itemID,
                            specialPrice: widget.model.specialPrice,
                            quantity: widget.model.quantity - 1,
                            urlKey: widget.model.urlKey
                          ));
                        } else {
                          if(widget.model.keyId != null){
                            removeItem(widget.model.keyId!);
                            //allClear();
                            print("remove item");
                          }else{
                            print("id is null");
                           // allClear();
                          }
                        }
                        //await model.getCart(context);
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${widget.model.quantity}',
                      style: GoogleFonts.nunitoSans(color: Colors.white,
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.add,color: Colors.white),
                      onPressed: () async {
                        print('started');
                        setState(() {
                          quantity++;
                        });
                        updateCartItem(DbCartModel(
                          keyId:  widget.model.keyId!,
                          itemName: widget.model.itemName,
                          imageUrl: widget.model.imageUrl,
                          unitPrice: widget.model.unitPrice,
                          itemID: widget.model.itemID,
                          specialPrice: widget.model.specialPrice,
                          quantity: widget.model.quantity + 1,
                            urlKey: widget.model.urlKey
                        ));
                        //await model.getCart(context);
                        print('ended');
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        '₹ ${(widget.model.quantity * widget.model.unitPrice).toStringAsFixed(2)}',
                        style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w700,fontSize: 13,color: Colors.grey),
                      ),
                      Text(
                         "₹ ${(widget.model.unitPrice+5).toStringAsFixed(2)}",
                          style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.redAccent,
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
