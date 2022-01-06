import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:portfolio/service/calendarService.dart';

class CalendarCt with ChangeNotifier {
  CalendarService _calendarService = CalendarService();

  CalendarCt(){
    this.getDays();
  }

  // todo highlight selectedDay
  int _selectedDay = DateTime.now().weekday;
  int get selectedDay => this._selectedDay;
  set selectedDay(int i) => throw "error";

  int _selectedMonth = DateTime.now().month;
  String get selectedMonth => this._calendarService.monthToString(month: this._selectedMonth);
  set selectedMonth(String s) => throw "error";

  int _selectedYear = DateTime.now().year;
  int get selectedYear => this._selectedYear;
  set selectedYear(int i) => throw "error";

  int? _firstDayOfMonth;
  set firstDayOfMonth(int i) => throw "error";

  int? _numOfWeeks;
  int? get numOfWeeks => this._numOfWeeks!;
  set numOfWeeks(int? i) => throw "error";

  int? _totalNumOfDays;
  set totalNumOfDays(int? i) => throw "error";

  int? _nextMonthFirstDay;
  set nextMonthFirstDay(int? i) => throw "error";

  List<List<int>>? _listOfColumnDays;
  List<List<int>>? get listOfColumnDays => this._listOfColumnDays;

  void getDays(){
    this._firstDayOfMonth = this._calendarService.getFirstDayOfMonth(year: this._selectedYear, month: this._selectedMonth);
    this._totalNumOfDays = this._calendarService.getTotalDays(month: this._selectedMonth);
    this._numOfWeeks = this._calendarService.getNumOfWeeks(totalDays: this._totalNumOfDays!, firstDay: this._firstDayOfMonth!);
    this._nextMonthFirstDay = this._calendarService.getFirstDayOfMonth(
        year: this._selectedMonth == 12 ? this._selectedYear+1 : this._selectedYear,
        month: this._selectedMonth == 12 ? 1 : this._selectedMonth+1,
    );
    this._listOfColumnDays = this._calendarService.getDays(
      numOfWeeks: this._numOfWeeks!,
      firstDay: this._firstDayOfMonth!,
      currentMonth: this._selectedMonth,
      nextMonthFirstDay: this._nextMonthFirstDay!,
    );

    this.notifyListeners();
  }

  void changeToPrevMonth() {
    if (this._selectedMonth == 1) {
      this._selectedMonth = 12;
      this._selectedYear -= 1;
    } else {
      this._selectedMonth -= 1;
    }
    this.notifyListeners();
    this.getDays();
  }

  void changeToNextMonth() {
    if (this._selectedMonth == 12) {
      this._selectedMonth = 1;
      this._selectedYear += 1;
    } else {
      this._selectedMonth += 1;
    }
    this.notifyListeners();
    this.getDays();
  }

}