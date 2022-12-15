import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/feturedItem_model.dart';
import '../provider/feturedItem_provider.dart';
import '../resources/app_utils.dart';
import '../resources/colors.dart';
import '../screens/details_screen.dart';
import 'featuredItem_widget.dart';
class FeaturedItems extends StatefulWidget {
  final bool inHome;
  final String title;
  const FeaturedItems({
    Key? key, required this.inHome, required this.title,
  }) : super(key: key);

  @override
  State<FeaturedItems> createState() => _FeaturedItemsState();
}

class _FeaturedItemsState extends State<FeaturedItems> {
  int quantity = 0;
  List<ItemModel> randomList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final state = Provider.of<ItemProvider>(context, listen: false);
    randomList = state.frequentItemList..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ItemProvider>(context);
    print(randomList.length);
    return state.frequentItemList.isNotEmpty
        ? Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      //color: Colors.grey[100],
          child: Column(
      children: [
       const SizedBox(
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.nunitoSans(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                widget.inHome?TextButton(
                    onPressed: () {
                      print(
                        'view all',
                      );
                      // navigateToPage(context,
                      //     AllFrequentList(frequentItems: randomList));
                    },
                    child: Row(
                      children: [
                        Text('See More',
                            style: GoogleFonts.nunitoSans(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.pink)),
                        const SizedBox(width: 5,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: primaryRed,
                           size: 11,
                        )
                      ],
                    )):SizedBox(height: 5,),
              ],
            ),
          ),
          Container(
            margin:
            const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            height: MediaQuery.of(context).size.height/3.5,
            child: Consumer<ItemProvider>(builder: (context, model, _) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: randomList.length ,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        print("urlkey=${randomList[index].urlKey!}");
                        if(widget.inHome){
                          navigateToPage(context,
                              ProductDetails(
                                urlKey: randomList[index].urlKey!,
                                itemId: randomList[index].itemID!,
                                //model: randomList[index],
                              ));
                        }

                      },
                      child: FrequentItemBlock(
                        data: randomList[index],
                      ),
                    );
                  });
            }),
          ),
      ],
    ),
        )
        : SizedBox(
      height: 10,
    );
  }
}
