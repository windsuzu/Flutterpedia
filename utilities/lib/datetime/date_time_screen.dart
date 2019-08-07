import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DateTime Utilities"),
      ),
      body: Center(
        child: Text(convertDateTimeToString(getCurrentDateTime(), "dd/MM/yy HH:mm")),
      ),
    );
  }

  DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  DateTime getSpecificDateTime(
      int year, int month, int day, int hour24, int min, int sec) {
    // Get the date time of 2000/07/09 13:30
    return DateTime(year, month, day, hour24, min, sec);
  }

  String convertDateTimeToString(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat ?? "yyyy-MM-dd hh:mm:ss").format(dateTime);
  }

  DateTime parseStringToDateTime(String dateTimeString, String dateFormat) {
    return DateFormat(dateFormat ?? "yyyy-MM-dd hh:mm:ss")
        .parse(dateTimeString);
  }

  bool date1IsBeforeDate2(DateTime date1, DateTime date2) {
    return date1.isBefore(date2);
  }

  bool date1IsAfterDate2(DateTime date1, DateTime date2) {
    return date1.isAfter(date2);
  }

  int getDurationDaysBetweenDates(DateTime date1, DateTime date2) {
    return date1.difference(date2).inDays; // can be inMinutes, inHours
  }

  DateTime addDaysIntoDate(DateTime date, Duration days) {
    return date.add(days ?? Duration(days: 10));
  }
}
