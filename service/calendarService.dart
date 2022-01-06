import 'dart:ui';

class CalendarService {

  String monthToString({required int month}){
    switch (month) {
      case 1: return "Jan";
      case 2: return "Feb";
      case 3: return "March";
      case 4: return "April";
      case 5: return "May";
      case 6: return "June";
      case 7: return "July";
      case 8: return "August";
      case 9: return "Sept";
      case 10: return "Oct";
      case 11: return "Nov";
      case 12: return "Dec";
    }
    return "";
  }

  static String weekdayString({required int row}) {
    try {
      switch (row) {
        case 0: return "Sun";
        case 1: return "Mon";
        case 2: return "Tue";
        case 3: return "Wed";
        case 4: return "Thu";
        case 5: return "Fri";
        case 6: return "Sat";
      }
    } catch (e) {
      throw e.toString();
    }
    return "";
  }

  // returns "weekday" int
  int getFirstDayOfMonth({required int year, required int month}) {
    int _firstDay = DateTime.utc(year, month, 1).weekday;
    if (DateTime.utc(year, month, 1).weekday == 7) {
      return 0;
    } else {
      return _firstDay;
    }
  }

  int? getTotalDays({required int month}){
    // todo february every 4 years has 29 days
    switch (month) {
      case 1: return 31;
      case 2: return 28;
      case 3: return 31;
      case 4: return 30;
      case 5: return 31;
      case 6: return 30;
      case 7: return 31;
      case 8: return 31;
      case 9: return 30;
      case 10: return 31;
      case 11: return 30;
      case 12: return 31;
    }
  }

  int getNumOfWeeks({required int totalDays, required int firstDay}){
    return ((firstDay + totalDays) / 7).ceil();
  }

  List<List<int>>? getDays({required int numOfWeeks, required int firstDay, required int currentMonth, required int nextMonthFirstDay}){
    List<List<int>> _daysList = [];
    int _prevMonthTotalDays = this.getTotalDays(month: currentMonth == 1 ? 12 : currentMonth-1)!;
    for (int i=0; i < numOfWeeks; i++) {
      _daysList.add(List.generate(7, (index) {
        // first week
        if (i==0) {
          if (index >= firstDay) {
            return 1 + (index-firstDay);
          } else {
            return _prevMonthTotalDays - (firstDay-index) + 1;
          }
          // other weeks
        } else if (i < numOfWeeks-1) {
          return _daysList[i-1][6] + 1 + index;
          // last week
        } else {
          if (index >= nextMonthFirstDay && nextMonthFirstDay != 0) {
            return 1 + (index-nextMonthFirstDay);
          } else {
            return _daysList[i-1][6] + 1 + index;
          }
        }
      }));
    }
    return _daysList;
  }

  static Color tileColor({required int columnIndex, required int dayIndex, required listOfColumnDays, required numOfWeeks}){
    int _firstDayIndex = listOfColumnDays[0].indexOf(1);
    int _nextMonthFirstDayIndex = listOfColumnDays[numOfWeeks-1].indexOf(1);
    if (columnIndex == 0) {
      if (dayIndex >= _firstDayIndex) {
        return Color.fromRGBO(255, 255, 255, 1.0);
      } else {
        return Color.fromRGBO(211, 211, 211, 1.0);
      }
    } else if (columnIndex == listOfColumnDays.length-1) {
      if (dayIndex < _nextMonthFirstDayIndex || _nextMonthFirstDayIndex == -1) {
        return Color.fromRGBO(255, 255, 255, 1.0);
      } else {
        return Color.fromRGBO(211, 211, 211, 1.0);
      }
    } else {
      return Color.fromRGBO(255, 255, 255, 1.0);
    }
  }
}