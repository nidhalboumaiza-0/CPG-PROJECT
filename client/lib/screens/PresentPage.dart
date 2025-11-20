import 'dart:async';
import 'dart:io';
import 'package:table_calendar/table_calendar.dart';
import 'package:client/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../API/getInternAbsences.dart';

late Future absent;

class PresentPage extends StatefulWidget {
  String id;
  PresentPage({required this.id});

  @override
  State<PresentPage> createState() => _PresentPageState();
}

class _PresentPageState extends State<PresentPage> {
  @override
  void initState() {
    super.initState();
    absent = getInternAbsence(widget.id);
  }

  @override
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _events = {};
  List<MapEntry<DateTime, List<dynamic>>> myList = [];
  // --------------------------------------
  // --------------------------------------
  Map<DateTime, List<dynamic>> _groupEvents(List<dynamic> events) {
    Map<DateTime, List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(DateTime.parse(event).year,
          DateTime.parse(event).month, DateTime.parse(event).day, 12);
      if (data[date] == null) data[date] = [];
      data[date]?.add(event);
    });
    return data;
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Follow presence',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          elevation: 0,
          backgroundColor: Colors.black87,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: FutureBuilder(
          future: absent,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              Object? e = snapshot.error;
              String errorMessage = '';
              if (e is SocketException) {
                errorMessage =
                    'Unable to connect to server. Please check your internet connection.';
              } else if (e is TimeoutException) {
                errorMessage = 'Connection timed out. Please try again later.';
              } else {
                errorMessage = 'An error occurred: $e';
              }
              // Display an error message
              return Text(errorMessage);
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xff284F7B),
                ),
              );
            }
            if (!snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return Text('No data available');
            }
            if (snapshot.hasData) {
              List<dynamic> allEvents = snapshot.data!['absence'];

              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              }
              myList = _events.entries.toList();
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff284F7B),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xff284F7B),
                        child: TableCalendar(
                          calendarBuilders: CalendarBuilders(
                            // Customize the day cell based on its events
                            defaultBuilder: (context, date, _) {
                              final eventColors =
                                  <Color>[]; // List of colors for events

                              // Add a color for each event on this day

                              // Return a Container widget with the event colors as backgrounds
                              return Container(
                                margin: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF54C0CE),
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          eventLoader: (day) => myList
                              .where((event) => isSameDay(event.key, day))
                              .toList(),
                          daysOfWeekStyle: DaysOfWeekStyle(
                            weekdayStyle: TextStyle(color: Colors.white),
                          ),
                          headerStyle: KhederTextStyle,
                          locale: "en_EN",
                          firstDay: DateTime.parse(snapshot.data!['dateStart']),
                          lastDay: DateTime.parse(snapshot.data!['dateFinish']),
                          focusedDay:
                              DateTime.parse(snapshot.data!['dateStart']),
                          calendarFormat: _calendarFormat,
                          calendarStyle: KcalenderTextStyle,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onFormatChanged: (format) {
                            if (_calendarFormat != format) {
                              // Call `setState()` when updating calendar format
                              setState(() {
                                _calendarFormat = format;
                              });
                            }
                          },
                          onPageChanged: (focusedDay) {
                            // No need to call `setState()` here
                            _focusedDay = focusedDay;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xff284F7B),
              ),
            );
          },
        ),
      ),
    );
  }
}
