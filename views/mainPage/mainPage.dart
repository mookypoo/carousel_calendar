import 'dart:io';

import 'package:flutter/material.dart';

import 'androidMainPage.dart';
import 'iosMainPage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {

    return Platform.isAndroid
      ? AndroidMainPage()
      : IosMainPage();
  }
}

