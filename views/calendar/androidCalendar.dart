import 'package:flutter/material.dart';
import 'package:portfolio/controllers/calendarCt.dart';
import 'package:portfolio/service/calendarService.dart';

class AndroidCalendar extends StatelessWidget {
  const AndroidCalendar({Key? key, required this.calendarCt}) : super(key: key);

  final CalendarCt calendarCt;

  Widget _weekdayRow({required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: List.generate(7, (a) => a).map((x) => Expanded(
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Center(child: Text(CalendarService.weekdayString(row: x))),
          ),
        )).toList(),
      ),
    );
  }

  Widget _weekRow({required int column, required BuildContext context}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: List.generate(7, (a) => a).map((dayIndex) {
          int _day = this.calendarCt.listOfColumnDays![column][dayIndex];
          return Expanded(
            child: Container(
              height: 80.0,
              decoration: BoxDecoration(
                border: Border.all(),
                color: CalendarService.tileColor(
                  columnIndex: column,
                  dayIndex: dayIndex,
                  listOfColumnDays: this.calendarCt.listOfColumnDays,
                  numOfWeeks: this.calendarCt.numOfWeeks,
                ),
              ),
              child: Text("$_day", textAlign: TextAlign.center,),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          leading: IconButton(
            iconSize: 28.0,
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              this.calendarCt.changeToPrevMonth();
            },
          ),
          actions: [
            IconButton(
              iconSize: 28.0,
              icon: Icon(Icons.arrow_right),
              onPressed: () {
                this.calendarCt.changeToNextMonth();
              },
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(this.calendarCt.selectedMonth, style: TextStyle(fontSize: 20.0)),
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                      ),
                      Container(
                        child: Text(this.calendarCt.selectedYear.toString(), style: TextStyle(fontSize: 20.0)),
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int i) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    this._weekdayRow(context: context),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: List.generate(this.calendarCt.numOfWeeks!, (int index) {
                            return this._weekRow(column: index, context: context);
                          }),
                        ),
                      ),
                    ),

                  ],
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}
