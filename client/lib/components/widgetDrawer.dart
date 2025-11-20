import 'package:client/screens/affectInternPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/PresentInternScreen.dart';
import '../screens/loginScreen.dart';

class widgetDrawer extends StatelessWidget {
  const widgetDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.7,
      child: Material(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              child: ListTile(
                leading: Image.asset('images/logo.jpg'),
                title: Text(
                  'Company of Phosphates of Gafsa',
                  style: TextStyle(fontSize: 8, color: Color(0xff0C70B7)),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              children: [
                Text(
                  '     Interns :',
                  style: TextStyle(color: Colors.black.withOpacity(0.4)),
                ),
                SizedBox(
                  width: size.width * 0.4,
                ),
                Icon(
                  Icons.settings,
                  size: 18,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
            Divider(
              height: 6,
              thickness: 1,
              indent: 10,
              color: Colors.black.withOpacity(0.189),
            ),
            ListTile(
              leading: Icon(Icons.timer_rounded, color: Color(0xff0C70B7)),
              title: Text(
                'Non affected intern',
                style: TextStyle(
                    color: Color(0xff0C70B7),
                    fontFamily: 'Dubai',
                    fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => affectInternScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Color(0xff0C70B7)),
              title: Text(
                'affected intern',
                style: TextStyle(
                    color: Color(0xff0C70B7),
                    fontFamily: 'Dubai',
                    fontSize: 11),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PresentInternScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: size.height * 0.55,
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xff0C70B7)),
              title: Text(
                'Log out',
                style: TextStyle(
                    color: Color(0xff0C70B7).withOpacity(0.6),
                    fontFamily: 'Dubai',
                    fontSize: 11),
              ),
              onTap: () async {
                Navigator.pushNamed(context, '/');
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
              },
            ),
          ],
        ),
      ),
    );
  }

// Widget menuItem({required IconData icon, required String text}) {
//   final color = Colors.black;
//   return ListTile(
//     leading: Icon(icon, color: color),
//     title: Text(
//       text,
//       style: TextStyle(color: Colors.black, fontFamily: 'Dubai'),
//     ),
//     onTap: () {
//       Navigator.pop(context);
//     },
//   );
// }
}

// Widget menuItem({required IconData icon, required String text}) {
//   final color = Colors.black;
//   return ListTile(
//     leading: Icon(Icons.logout, color: Colors.black),
//     title: Text(
//       'logout',
//       style: TextStyle(color: Colors.black, fontFamily: 'Dubai'),
//     ),
//     onTap: () {
//       Navigator.pop(context),
//     },
//   );
// }
