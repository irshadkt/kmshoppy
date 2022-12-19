import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../db/db_functions.dart';
import '../../db/db_model.dart';
import '../../models/feturedItem_model.dart';
import '../../provider/cart_provider.dart';
import '../../provider/feturedItem_provider.dart';
import '../../resources/app_utils.dart';
import '../../resources/colors.dart';
import '../../services/dioHelper.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/featured_items.dart';
import '../details_screen.dart';
import 'cart_item.dart';

class MyCart extends StatefulWidget {
  final bool inDetail;
  const MyCart({Key? key, required this.inDetail}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool isLoading = false;
  bool payNow = true;
  double subtotal = 0;
  //Razorpay razorpay = Razorpay();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  getList() async {
    final state = Provider.of<CartProvider>(context, listen: false);
    if (mounted) {
      setState(() => isLoading = true);
      //await DioHelper().getSubCategoryItems(context, 352);
     // await state.getCart(context);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context, listen: false);
    final state = Provider.of<ItemProvider>(context);
    Size size = MediaQuery.of(context).size;
    return
      ValueListenableBuilder(valueListenable: cartListNotifier,
        builder: (BuildContext ctx,List<DbCartModel>cartList,Widget ? child){
          var itemTotal = 0.0;
          var deliveryCharge = 0.0;
          for (var element in cartList) {
            itemTotal += element.unitPrice * element.quantity;
          }
          // deliveryCharge =
          // model.selectedDeliveryMode == "SMART DELIVERY" && itemTotal < 1000
          //     ? 40
          //     : 0;
          //subtotal = itemTotal + deliveryCharge;
          subtotal = itemTotal;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.black,
              leading: IconButton(
                icon:  const Icon(Icons.arrow_back,color: Colors.redAccent,size: 30,),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  Text(
                    'Cart (${cartList.length})',
                    style: GoogleFonts.nunitoSans(
                      color: Colors.white,
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const Spacer(),
                  TextButton(onPressed: (){
                    cartClear();
                  }, child: Text(
                    'Empty Cart',
                    style: GoogleFonts.nunitoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700, fontSize: 15),
                  ),)

                ],
              ),

            ),
            body: SafeArea(
              child: isLoading
                  ? Center(child: appLoading())
                  : cartList.isNotEmpty
                  ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      physics:const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartList.length,
                      itemBuilder: (ctx, index) => InkWell(
                          onTap: () async {
                            navigateToPage(context,
                                ProductDetails(itemId:cartList[index].itemID,
                                urlKey:cartList[index].urlKey,
                                fromCart: true,));
                            // Future.delayed(
                            //     Duration.zero,
                            //         () => navigateToPage(
                            //         context,
                            //         ProductDetails(
                            //           model: product,
                            //           fromCart: true,
                            //         )));
                          },
                          child: CartItem(model:cartList[index])),
                      separatorBuilder:
                          (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(
                        thickness: 5,
                        color: Colors.grey[300],
                      ),
                    ),
                    const FeaturedItems(title: 'You Might Also Like',inHome: false),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("lib/images/pngoffer.png",height: 25,
                           // color: Colors.blue,
                            width: 25,
                           // bundle: ,
                          ),
                          buildTitle('  Avail offers / Coupons',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900)),
                          const Spacer(),
                         const Icon(Icons.play_arrow,
                           color: Colors.pink,size: 20,),

                        ],
                      ),
                    ),
                     Padding(
                       padding:const EdgeInsets.symmetric(horizontal: 16),
                       child: Divider(
                        thickness: 5,
                        color: Colors.grey[300],
                    ),
                     ),
                    Container(
                      // height: 600,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTitle('Bill Details',
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900)),
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTitle('Item Total',
                                  style: GoogleFonts.nunitoSans(
                                      color: Colors.black38,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              buildValue( '₹ ${itemTotal.toStringAsFixed(2)}',
                                  // '₹${subtotal.toStringAsFixed(2)}',
                                  style: GoogleFonts.nunitoSans( fontSize: 15,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                          // buildBillDetails('Discount', 0),
                          // buildBillDetails('Carry bag Charge', 0),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTitle('Product Discount',
                                  style: GoogleFonts.nunitoSans(
                                    color: Colors.black38,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              buildValue( '₹ 5.00',
                                 // '₹${subtotal.toStringAsFixed(2)}',
                                  style: GoogleFonts.nunitoSans( fontSize: 15,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w800)),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          // buildBillDetails(
                          //     'Delivery Charge', deliveryCharge),
                          const Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTitle('Sub Total',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                              buildValue(
                                  '₹ ${subtotal.toStringAsFixed(2)}',
                                  style: GoogleFonts.nunitoSans( fontSize: 18,
                                      fontWeight: FontWeight.w900)),
                            ],
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 1,vertical: 10),
                            padding: EdgeInsets.all(12),
                            //height: 40,
                            decoration: BoxDecoration(
                                color: Colors.pink,
                                // border: Border.all(color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text("SELECT DELIVERY OPTIONS",style: GoogleFonts.nunitoSans(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                            ),
                          ),
                          // buildTitle('DELIVERY MODE',
                          //     style: GoogleFonts.nunitoSans(
                          //         color: greyColor,
                          //         fontWeight: FontWeight.w800)),
                         // buildDeliveryTile("SMART DELIVERY"),
                         // buildDeliveryTile("NORMAL DELIVERY"),
                        ],
                      ),
                    )
                  ],
                ),
              )
                  :const Center(
                child: SizedBox(
                  child: Text("Cart is empty"),
                ),
              ),
            ),
            bottomNavigationBar: BottomBarListWidget(ind: 2,inDetailPage: widget.inDetail
            ),

          );
        });


    //   Consumer<CartProvider>(builder: (context, model, _) {
    //   var itemTotal = 0.0;
    //   var deliveryCharge = 0.0;
    //   for (var element in model.cartList) {
    //     itemTotal += element.salesPrice! * element.quantity;
    //   }
    //   // deliveryCharge =
    //   // model.selectedDeliveryMode == "SMART DELIVERY" && itemTotal < 1000
    //   //     ? 40
    //   //     : 0;
    //   //subtotal = itemTotal + deliveryCharge;
    //   subtotal = itemTotal;
    //   return Scaffold(
    //     appBar: AppBar(
    //       toolbarHeight: 80,
    //       automaticallyImplyLeading: false,
    //       backgroundColor: Colors.white,
    //       foregroundColor: Colors.black,
    //       leading: IconButton(
    //         icon:  const Icon(Icons.arrow_back),
    //         onPressed: () => Navigator.pop(context),
    //       ),
    //       title: Text(
    //         'My Cart',
    //         style: GoogleFonts.nunitoSans(
    //             fontWeight: FontWeight.w700, fontSize: 20),
    //       ),
    //     ),
    //     body: SafeArea(
    //       child: isLoading
    //           ? Center(child: appLoading())
    //           : model.cartList.isNotEmpty
    //           ? SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             ListView.separated(
    //               physics: NeverScrollableScrollPhysics(),
    //               shrinkWrap: true,
    //               itemCount: model.cartList.length,
    //               itemBuilder: (ctx, index) => InkWell(
    //                   onTap: () async {
    //                     // final response = await DioHelper()
    //                     //     .getItemsById(context,
    //                     //     model.cartList[index].itemID);
    //                     // final product =
    //                     // ItemModel.fromJson(response.data['data']);
    //                     // print(product.toJson());
    //                     // Future.delayed(
    //                     //     Duration.zero,
    //                     //         () => navigateToPage(
    //                     //         context,
    //                     //         ProductDetails(
    //                     //           model: product,
    //                     //           fromCart: true,
    //                     //         )));
    //                   },
    //                   child: CartItem(model: model.cartList[index])),
    //               separatorBuilder:
    //                   (BuildContext context, int index) {
    //                 return Divider();
    //               },
    //             ),
    //             Divider(
    //               thickness: 5,
    //             ),
    //             // Container(
    //             //   // height: 600,
    //             //   margin: EdgeInsets.symmetric(
    //             //       horizontal: 16, vertical: 5),
    //             //   child: Column(
    //             //     mainAxisSize: MainAxisSize.min,
    //             //     crossAxisAlignment: CrossAxisAlignment.start,
    //             //     children: [
    //             //       buildTitle('BILL DETAILS',
    //             //           style: GoogleFonts.nunitoSans(
    //             //               color: greyColor,
    //             //               fontWeight: FontWeight.w800)),
    //             //       buildBillDetails('Item Total', itemTotal),
    //             //       // buildBillDetails('Discount', 0),
    //             //       // buildBillDetails('Carry bag Charge', 0),
    //             //       buildBillDetails(
    //             //           'Delivery Charge', deliveryCharge),
    //             //       ListTile(
    //             //         leading: buildTitle('Sub Total',
    //             //             style: GoogleFonts.nunitoSans(
    //             //                 fontWeight: FontWeight.w900)),
    //             //         trailing: buildValue(
    //             //             '₹${subtotal.toStringAsFixed(2)}',
    //             //             style: GoogleFonts.nunitoSans(
    //             //                 fontWeight: FontWeight.w900)),
    //             //       ),
    //             //       buildTitle('DELIVERY MODE',
    //             //           style: GoogleFonts.nunitoSans(
    //             //               color: greyColor,
    //             //               fontWeight: FontWeight.w800)),
    //             //       buildDeliveryTile("SMART DELIVERY"),
    //             //       buildDeliveryTile("NORMAL DELIVERY"),
    //             //     ],
    //             //   ),
    //             // )
    //           ],
    //         ),
    //       )
    //           : Center(
    //         child: SizedBox(
    //           child: Text("Cart is empty"),
    //         ),
    //       ),
    //     ),
    //   //   bottomNavigationBar:
    //   // Consumer2<AddressProvider, CartProvider>(
    //   //       builder: (context, model, cartModel, _) {
    //   //         return cartModel.cartList.isNotEmpty
    //   //             ? model.selectedAddressId == 0
    //   //             ? InkWell(
    //   //             onTap: () async {
    //   //               SharedPreferences prefs =
    //   //               await SharedPreferences.getInstance();
    //   //               final isLogged = prefs.getBool('isLogged') ?? false;
    //   //               if (isLogged) {
    //   //                 await showAddressSheet();
    //   //               } else {
    //   //                 navigateToPage(
    //   //                     context,
    //   //                     LoginPage(
    //   //                       isEntered: true,
    //   //                     ));
    //   //               }
    //   //             },
    //   //             child: Container(
    //   //               height: 45,
    //   //               width: double.infinity,
    //   //               margin: const EdgeInsets.symmetric(
    //   //                   horizontal: 15, vertical: 10),
    //   //               padding: const EdgeInsets.symmetric(horizontal: 15),
    //   //               decoration: BoxDecoration(
    //   //                 color: primaryRed,
    //   //                 borderRadius: BorderRadius.circular(20),
    //   //                 // border: Border(top: BorderSide(width: 10)),
    //   //               ),
    //   //               child: Center(
    //   //                 child: Text(
    //   //                   'Add Delivery Address',
    //   //                   maxLines: 1,
    //   //                   style: GoogleFonts.nunitoSans(
    //   //                       fontSize:
    //   //                       MediaQuery.of(context).size.width * .045,
    //   //                       fontWeight: FontWeight.w700,
    //   //                       color: Colors.white),
    //   //                   overflow: TextOverflow.ellipsis,
    //   //                 ),
    //   //               ),
    //   //             ))
    //   //             : Container(
    //   //           decoration:const BoxDecoration(
    //   //             boxShadow: [
    //   //               BoxShadow(
    //   //                   color: Colors.black,
    //   //                   spreadRadius: .1,
    //   //                   blurRadius: .5),
    //   //               BoxShadow(
    //   //                   color: Colors.white,
    //   //                   spreadRadius: .3,
    //   //                   blurRadius: .9)
    //   //             ],
    //   //           ),
    //   //           child: Column(
    //   //             crossAxisAlignment: CrossAxisAlignment.start,
    //   //             mainAxisSize: MainAxisSize.min,
    //   //             children: [
    //   //               Padding(
    //   //                 child: buildTitle('DELIVER TO',
    //   //                     style: GoogleFonts.nunitoSans(
    //   //                         fontWeight: FontWeight.w400,
    //   //                         fontSize: size.width * .03)),
    //   //                 padding: EdgeInsets.symmetric(
    //   //                     horizontal: 15, vertical: 5),
    //   //               ),
    //   //               Padding(
    //   //                 padding:const EdgeInsets.symmetric(horizontal: 15),
    //   //                 child: Row(
    //   //                   mainAxisSize: MainAxisSize.min,
    //   //                   children: [
    //   //                     // Image.asset(
    //   //                     //   model.addressList
    //   //                     //       .singleWhere((element) =>
    //   //                     //   element.addressID ==
    //   //                     //       model.selectedAddressId)
    //   //                     //       .addressType ==
    //   //                     //       "HOME"
    //   //                     //       ? homeIcon
    //   //                     //       : officeIcon,
    //   //                     //   width: 20,
    //   //                     // ),
    //   //                     SizedBox(
    //   //                       width: 5,
    //   //                     ),
    //   //                     Text(
    //   //                         model.addressList
    //   //                             .singleWhere((element) =>
    //   //                         element.addressID ==
    //   //                             model.selectedAddressId)
    //   //                             .addressType ==
    //   //                             "HOME"
    //   //                             ? "HOME: "
    //   //                             : "OFFICE: ",
    //   //                         style: GoogleFonts.nunitoSans(
    //   //                             fontWeight: FontWeight.w700)),
    //   //                     // Expanded(
    //   //                     //   child: Text(
    //   //                     //     buildAddress(model.addressList.singleWhere(
    //   //                     //             (element) =>
    //   //                     //         element.addressID ==
    //   //                     //             model.selectedAddressId)),
    //   //                     //     maxLines: 1,
    //   //                     //     overflow: TextOverflow.ellipsis,
    //   //                     //   ),
    //   //                     // ),
    //   //                     TextButton(
    //   //                         onPressed: () async {
    //   //                           //await showAddressSheet();
    //   //                         },
    //   //                         child: Text(
    //   //                           'CHANGE',
    //   //                           style: GoogleFonts.nunitoSans(
    //   //                               color: primaryRed,
    //   //                               fontWeight: FontWeight.w700,
    //   //                               fontSize: 10),
    //   //                         ))
    //   //                   ],
    //   //                 ),
    //   //               ),
    //   //               // Row(
    //   //               //   mainAxisAlignment: MainAxisAlignment.end,
    //   //               //   children: [
    //   //               //     InkWell(
    //   //               //       onTap: (){
    //   //               //         setState(() {
    //   //               //           payNow=!payNow;
    //   //               //         });
    //   //               //       },
    //   //               //       child: Padding(
    //   //               //         padding: const EdgeInsets.symmetric(horizontal: 13.0),
    //   //               //         child: Text(payNow?"Pay Now":"Pay on Delivery",
    //   //               //             style: GoogleFonts.nunitoSans(
    //   //               //                 color: Colors.blue,
    //   //               //                 fontWeight: FontWeight.w700,
    //   //               //                 fontSize: 13)),
    //   //               //       ),
    //   //               //     ),
    //   //               //   ],
    //   //               // ),
    //   //               InkWell(
    //   //                 onTap: () {
    //   //
    //   //                   // navigateToPage(
    //   //                   //     context, PaymentScreen(subtotal: subtotal));
    //   //                 },
    //   //                 child: Container(
    //   //                   height: 45,
    //   //                   width: double.infinity,
    //   //                   margin: const EdgeInsets.symmetric(
    //   //                       horizontal: 15, vertical: 10),
    //   //                   padding:
    //   //                   const EdgeInsets.symmetric(horizontal: 15),
    //   //                   decoration: BoxDecoration(
    //   //                       color: primaryRed,
    //   //                       // border: Border(top: BorderSide(width: 10)),
    //   //                       borderRadius: BorderRadius.circular(20)),
    //   //                   child: Center(
    //   //                     child: Text(
    //   //                       'Proceed to Payment',
    //   //                       maxLines: 1,
    //   //                       style: GoogleFonts.nunitoSans(
    //   //                           fontSize:
    //   //                           MediaQuery.of(context).size.width *
    //   //                               .045,
    //   //                           fontWeight: FontWeight.w700,
    //   //                           color: Colors.white),
    //   //                       overflow: TextOverflow.ellipsis,
    //   //                     ),
    //   //                   ),
    //   //                 ),
    //   //               ),
    //   //             ],
    //   //           ),
    //   //         )
    //   //             : const SizedBox();
    //   //       }),
    //   );
    // });
  }

  // void handlePaymentErrorResponse(PaymentFailureResponse response) {
  //   /*
  //   * PaymentFailureResponse contains three values:
  //   * 1. Error Code
  //   * 2. Error Description
  //   * 3. Metadata
  //   * */
  //   showAlertDialog(context, "Payment Failed", "${response.message}"
  //       // "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}"
  //       );
  // }
  //
  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   /*
  //   * Payment Success Response contains three values:
  //   * 1. Order ID
  //   * 2. Payment ID
  //   * 3. Signature
  //   * */
  //   createOrder("ONLINE PAYMENT");
  //   //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  // }
  //
  // void handleExternalWalletSelected(ExternalWalletResponse response) {
  //   showAlertDialog(
  //       context, "External Wallet Selected", "${response.walletName}");
  // }
  //
  // void showAlertDialog(BuildContext context, String title, String message) {
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: Text("OK",
  //         style: GoogleFonts.nunitoSans(
  //             color: Colors.white, fontWeight: FontWeight.w700, fontSize: 10)),
  //     onPressed: () {
  //       Navigator.of(context);
  //     },
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title,
  //         style: GoogleFonts.nunitoSans(
  //             color: primaryRed, fontWeight: FontWeight.w700, fontSize: 15)),
  //     content: Text(message,
  //         style: GoogleFonts.nunitoSans(
  //             color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13)),
  //     actions: [
  //       continueButton,
  //     ],
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  // syncCart() async {
  //   final state = Provider.of<CartProvider>(context, listen: false);
  //   state.selectedPayment = 0;
  //   await state.getCart(context);
  //   var syncList = [];
  //   state.cartList.forEach((element) {
  //     syncList.add({"Quantity": element.quantity, "Barcode": element.barcode});
  //   });
  //   print('jsonEncode(syncList) ${jsonEncode(syncList)}');
  //   await DioHelper().syncCart(context, syncList);
  // }
  //
  // createOrder(String type) async {
  //   final state = Provider.of<CartProvider>(context, listen: false);
  //   final addressState = Provider.of<AddressProvider>(context, listen: false);
  //   var today = DateFormat("yyyy-MM-dd").format(DateTime.now());
  //   var timeLimit = DateTime.parse(today).add(Duration(hours: 18));
  //   var data = {
  //     "payment_method": type,
  //     "order_type": state.selectedDeliveryMode,
  //     // "order_type": widget.deliveryMode.toUpperCase(),
  //     // "delivery_date": DateFormat.yMMMd().format(DateTime.now()),
  //     // "delivery_time": DateFormat.jm().format(DateTime.now()),
  //     "delivery_date": state.selectedDeliveryMode == "SMART DELIVERY"
  //         ? DateFormat("yyyy-MM-dd").format(DateTime.now())
  //         : DateTime.now().isBefore(timeLimit)
  //         ? DateFormat("yyyy-MM-dd").format(DateTime.now())
  //         : DateFormat("yyyy-MM-dd")
  //         .format(DateTime.now().add(Duration(days: 1))),
  //     "delivery_time": state.selectedDeliveryMode == "SMART DELIVERY"
  //         ? DateFormat("h:mm a").format(DateTime.now().add(Duration(hours: 1)))
  //         : DateTime.now().isBefore(timeLimit)
  //         ? DateFormat("h:mm a")
  //         .format(DateTime.now().add(Duration(hours: 4)))
  //         : DateFormat("h:mm a").format(DateTime.parse(
  //         DateFormat("yyyy-MM-dd").format(DateTime.now()))
  //         .add(Duration(hours: 9))),
  //   };
  //   print(jsonEncode(data));
  //   await DioHelper()
  //       .createOrder(context, addressState.selectedAddressId, data);
  // }

  SizedBox buildBillDetails(String title, double amountValue) {
    return SizedBox(
      height: 40,
      child: ListTile(
        leading: buildTitle(title),
        trailing: buildValue('₹${amountValue.toStringAsFixed(2)}'),
      ),
    );
  }

  // String buildAddress(AddressData data) {
  //   String address = "";
  //   address += (data.name != null && data.name != "" ? "${data.name}" : "") +
  //       (data.address != null && data.address != ""
  //           ? ", ${data.address}"
  //           : "") +
  //       (data.buildingName != null && data.buildingName != ""
  //           ? ", ${data.buildingName}"
  //           : "") +
  //       (data.landmark != null && data.landmark != ""
  //           ? ", ${data.landmark}"
  //           : "") +
  //       (data.district != null && data.district != ""
  //           ? ", ${data.district}"
  //           : "") +
  //       (data.pinCode != null && data.pinCode != ""
  //           ? "\n${data.pinCode}"
  //           : "") +
  //       (data.mobile1 != null && data.mobile1 != "" ? "\n${data.mobile1}" : "");
  //   return address;
  // }

  // Future showAddressSheet() {
  //   Size size = MediaQuery.of(context).size;
  //   return showModalBottomSheet(
  //       context: context,
  //       enableDrag: true,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20), topRight: Radius.circular(20))),
  //       builder: (context) {
  //         // isCategoryChanged = false;
  //         return SingleChildScrollView(
  //           child: Consumer<AddressProvider>(builder: (context, model, _) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     margin: EdgeInsets.symmetric(vertical: 10),
  //                     height: 5,
  //                     width: 50,
  //                     decoration:const BoxDecoration(
  //                       color: greyColor,
  //                     ),
  //                   ),
  //                 ),
  //                 // Padding(
  //                 //   child: buildTitle('Select delivery address',
  //                 //       style: GoogleFonts.nunitoSans(
  //                 //           fontWeight: FontWeight.w800,
  //                 //           fontSize: size.width * .045)),
  //                 //   padding: EdgeInsets.symmetric(horizontal: 15),
  //                 // ),
  //                 // for (int index = 0; index < model.addressList.length; index++)
  //                 //   Column(
  //                 //     children: [
  //                 //       CartAddress(data: model.addressList[index])
  //                 //       // ListTile(
  //                 //       //   contentPadding:
  //                 //       //       EdgeInsets.symmetric(vertical: 5, horizontal: 20),
  //                 //       //   leading: Image.network(
  //                 //       //     categories[index].image!,
  //                 //       //     width: size.width * .1,
  //                 //       //     errorBuilder: (ctx, url, error) => Image.asset(
  //                 //       //       noImage,
  //                 //       //       width: size.width * .1,
  //                 //       //     ),
  //                 //       //   ),
  //                 //       //   title: Text(
  //                 //       //     categories[index].itemCategory!,
  //                 //       //     style: GoogleFonts.nunitoSans(),
  //                 //       //   ),
  //                 //       //   trailing: Image.asset(
  //                 //       //     arrowRightRed,
  //                 //       //     height: 20,
  //                 //       //   ),
  //                 //       //   onTap: () async {
  //                 //       //     setState(() {
  //                 //       //       // final prevId = widget.model.itemCategoryID;
  //                 //       //       // widget.model = categories[index];
  //                 //       //       // if (prevId != categories[index].itemCategoryID) {
  //                 //       //       //   isCategoryChanged = true;
  //                 //       //       // }
  //                 //       //     });
  //                 //       //     // Navigator.of(context).pop(isCategoryChanged);
  //                 //       //   },
  //                 //       // ),
  //                 //       // Divider()
  //                 //     ],
  //                 //   ),
  //                 InkWell(
  //                   onTap: () {
  //                    // navigateToPage(context, AddAddress());
  //                     // navigateToPage(context, CreateAddress());
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         border: Border.all(color: lightGreyColor),
  //                         borderRadius: BorderRadius.circular(12)),
  //                     margin:
  //                     EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                     padding:
  //                     EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         // Image.asset(
  //                         //   addRed,
  //                         //   width: 18,
  //                         // ),
  //                         SizedBox(
  //                           width: 8,
  //                         ),
  //                         Text(
  //                           'Add new address',
  //                           style: GoogleFonts.nunitoSans(
  //                               fontWeight: FontWeight.w700, color: primaryRed),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 // ListTile(
  //                 //   leading: new Icon(Icons.music_note),
  //                 //   title: new Text('Music'),
  //                 //   onTap: () {
  //                 //     Navigator.pop(context);
  //                 //   },
  //                 // ),
  //                 // ListTile(
  //                 //   leading: new Icon(Icons.videocam),
  //                 //   title: new Text('Video'),
  //                 //   onTap: () {
  //                 //     Navigator.pop(context);
  //                 //   },
  //                 // ),
  //                 // ListTile(
  //                 //   leading: new Icon(Icons.share),
  //                 //   title: new Text('Share'),
  //                 //   onTap: () {
  //                 //     Navigator.pop(context);
  //                 //   },
  //                 // ),
  //               ],
  //             );
  //           }),
  //         );
  //       });
  // }

  Widget buildTitle(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ??
          GoogleFonts.nunitoSans(
              color: Colors.black, fontWeight: FontWeight.w600),
    );
  }

  Widget buildValue(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? GoogleFonts.nunitoSans(fontWeight: FontWeight.w600),
    );
  }

  // buildDeliveryTile(String value, {String? payIcon}) {
  //   return Consumer<CartProvider>(builder: (context, model, _) {
  //     return RadioListTile(
  //       value: value,
  //       groupValue: model.selectedDeliveryMode,
  //       onChanged: (String? val) {
  //         if (val != null) {
  //           model.selectedDeliveryMode = val;
  //           model.notifyListeners();
  //           print(model.selectedDeliveryMode);
  //         }
  //       },
  //       // isThreeLine: true,
  //       activeColor: primaryRed,
  //       title: buildTitle(value,
  //           style: GoogleFonts.nunitoSans(
  //               fontWeight: FontWeight.w700, fontSize: 14)),
  //       subtitle: value == "SMART DELIVERY"
  //           ? buildValue('Delivery in 1 hr (Deliver charges may apply on this)')
  //           : null,
  //       // secondary: payIcon != null
  //       //     ? Image.asset(
  //       //         payIcon,
  //       //       )
  //       //     : null,
  //       toggleable: true,
  //       controlAffinity: ListTileControlAffinity.trailing,
  //       // subtitle: Text(buildAddress(widget.data)),
  //     );
  //   });
  // }
}
