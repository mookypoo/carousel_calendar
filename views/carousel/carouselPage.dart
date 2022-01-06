import 'dart:io';

import 'package:flutter/material.dart';
import 'package:portfolio/controllers/carouselPageProvider.dart';
import 'package:provider/provider.dart';

import 'androidCarousel.dart';
import 'iosCarousel.dart';

class CarouselPage extends StatelessWidget {
  CarouselPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarouselPageProvider _carouselPageProvider = Provider.of<CarouselPageProvider>(context);

    return Platform.isAndroid
      ? AndroidCarousel(carouselPageProvider: _carouselPageProvider)
      : IosCarousel();
  }
}




