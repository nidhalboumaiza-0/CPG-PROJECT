import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

const Kurl = "http://192.168.11.16:3006";

var KinputDecorationInstitue = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xffA5AAB7), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  hintText: 'Name',
  hintStyle: TextStyle(fontSize: 15),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  ),
);

const KdecorationTextField = InputDecoration(
  hintStyle: TextStyle(color: Colors.black54),
  hintText: 'Enter a value...',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff5277B4), width: 1),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff5277B4), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

const KloginBackgroundDecoration = BoxDecoration(
  image: DecorationImage(
      image: AssetImage("images/background.jpg"), fit: BoxFit.fill),
);

final KMiddleContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(30),
  color: Color(0xffC4CCD5).withOpacity(0.7),
);
const KresetPasswordTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    color: Color(0xff1C3368),
    fontSize: 15);

const KShimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
//-----------------CALENDER
final KcalenderTextStyle = CalendarStyle(
  markerMargin: EdgeInsets.only(top: 0),
  markerDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.redAccent,
  ),
  weekendTextStyle: TextStyle(color: Colors.grey),
  defaultTextStyle: TextStyle(color: Colors.white),
  disabledTextStyle: const TextStyle(color: Colors.white),
  holidayTextStyle: const TextStyle(color: Colors.white),
  weekNumberTextStyle: const TextStyle(fontSize: 12, color: Colors.white),
  todayDecoration: BoxDecoration(
      color: const Color.fromARGB(255, 40, 123, 112), shape: BoxShape.circle),
  //markerDecoration: BoxDecoration(color: Colors.red),
  selectedDecoration:
      BoxDecoration(color: Color(0xFF54C0CE), shape: BoxShape.circle),

  todayTextStyle: TextStyle().copyWith(color: Colors.white),
  outsideTextStyle: TextStyle().copyWith(color: Colors.white),
  outsideDaysVisible: false,
);
final KhederTextStyle = HeaderStyle(
  leftChevronIcon: Icon(
    Icons.chevron_left,
    color: Colors.white,
  ),
  rightChevronIcon: Icon(
    Icons.chevron_right,
    color: Colors.white,
  ),
  formatButtonDecoration: BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(20),
  ),
  formatButtonTextStyle: TextStyle(fontSize: 12.0, color: Colors.white),
  titleTextStyle: TextStyle(
    color: Colors.white,
  ),
);
final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
