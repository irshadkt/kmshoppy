import 'package:flutter/material.dart';
import 'package:kmshoppy/models/slider_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../resources/colors.dart';
Widget buildIndicator(int activeIndex, List<SliderModel> sliderList,
    {double dotWidth = 20, double strokeWidth = 10, double dotHeight = 4}) {
  return AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: sliderList.length,
    effect: JumpingDotEffect(
        dotColor: lightGreyColor,
        dotWidth: dotWidth,
        strokeWidth: strokeWidth,
        dotHeight: dotHeight,
        activeDotColor: primaryRed),
  );
}