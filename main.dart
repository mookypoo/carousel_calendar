import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/views/mainPage/mainPage.dart';
import 'package:provider/provider.dart';

import 'controllers/calendarCt.dart';
import 'controllers/carouselPageProvider.dart';

void main() => runApp(new Portfolio());

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  Widget _portfolio() {
    return Platform.isAndroid
      ? MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          onGenerateRoute: (RouteSettings route) {
            return MaterialPageRoute(
              builder: (BuildContext context) => MainPage(),
              settings: RouteSettings(name: MainPage.routeName),
            );
          },
        )
      : CupertinoApp(
          theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              textStyle: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: CupertinoColors.black,
              ),
            ),
          ),
          onGenerateRoute: (RouteSettings route) {
            return CupertinoPageRoute(
              builder: (BuildContext context) => MainPage(),
              settings: RouteSettings(name: MainPage.routeName),
            );
          }
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CarouselPageProvider>(create: (BuildContext context) => CarouselPageProvider()),
        ChangeNotifierProvider<CalendarCt>(create: (BuildContext context) => CalendarCt()),
      ],
      child: this._portfolio(),
    );
  }
}
