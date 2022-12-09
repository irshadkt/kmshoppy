import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/feturedItem_model.dart';
import '../provider/feturedItem_provider.dart';
import '../resources/colors.dart';
import 'featuredItem_widget.dart';
class FeaturedItems extends StatefulWidget {
  const FeaturedItems({
    Key? key,
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
        ? Column(
      children: [
       const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured products',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.w700, fontSize: 18),
              ),
              TextButton(
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
                              color: primaryRed)),
                      const SizedBox(width: 5,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: primaryRed,
                         size: 11,
                      )
                    ],
                  )),
            ],
          ),
        ),
        Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: MediaQuery.of(context).size.height/3.8,
          child: Consumer<ItemProvider>(builder: (context, model, _) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: randomList.length > 6 ? 6 : randomList.length,
                itemBuilder: (ctx, index) {
                  return InkWell(
                    onTap: () {
                      // navigateToPage(context,
                      //     ProductDetails(model: randomList[index]));
                    },
                    child: FrequentItemBlock(
                      data: randomList[index],
                    ),
                  );
                });
          }),
        ),
      ],
    )
        : SizedBox(
      height: 10,
    );
  }
}
