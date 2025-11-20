import 'package:client/screens/affectInternPage.dart';
import 'package:client/screens/instituteScreen.dart';
import 'package:client/screens/loginScreen.dart';
import 'package:client/screens/supervisorPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/homePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  var ch;
  if (token != null && token.isNotEmpty) {
    ch = '/homePage';
  } else {
    ch = '/';
  }
  runApp(CPG(initialRoute: ch));
}

class CPG extends StatelessWidget {
  late String initialRoute;
  CPG({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en'), const Locale('fr')],
      initialRoute: initialRoute,
      routes: {
        '/': (context) => loginScreen(),
        '/homePage': (context) => homePage(),
        '/supervisorPage': (context) => supervisorPage(),
        '/institute': (context) => instituteScreen(),
        '/affectInternScreen': (context) => affectInternScreen(),
      },
    );
  }
}
