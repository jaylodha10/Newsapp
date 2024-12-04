import 'package:flutter/material.dart';
import 'package:newsapp/models/slider_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BuildIndicator {
  int activeIndex;
  List<SliderModel> sliderList = [];
  BuildIndicator({
    required this.activeIndex,
    required this.sliderList,
  });
  Widget buildIndicator() {
    return sliderList.isEmpty
        ? const SizedBox()
        : AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: 5,
            effect: const SlideEffect(
                activeDotColor: Colors.blue, dotWidth: 10, dotHeight: 10),
          );
  }
}
