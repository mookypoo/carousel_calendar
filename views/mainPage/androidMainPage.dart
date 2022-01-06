import 'package:flutter/material.dart';
import 'package:portfolio/views/calendar/calendarPage.dart';
import 'package:portfolio/views/carousel/carouselPage.dart';

class AndroidMainPage extends StatefulWidget {
  AndroidMainPage({Key? key}) : super(key: key);

  @override
  State<AndroidMainPage> createState() => _AndroidMainPageState();
}

class _AndroidMainPageState extends State<AndroidMainPage> {

  int _index = 1;

  List<Widget> _tabs = [
    CarouselPage(),
    CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._tabs[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int i) {
          this.setState(() {
            this._index = i;
          });
        },
        currentIndex: this._index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.slideshow),
            label: "Carousel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: "Calendar",
          ),
        ],
      ),
    );
  }
}
