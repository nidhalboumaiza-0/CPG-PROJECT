import 'package:client/screens/FirstPageOfHome.dart';
import 'package:client/screens/internersPage.dart';
import 'package:client/screens/supervisorPage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/getInternAbsences.dart';
import '../components/widgetDrawer.dart';
import 'instituteScreen.dart';
import 'loginScreen.dart';

class homePage extends StatefulWidget {
  var i;
  homePage({this.i});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Supervisors Management';
      case 2:
        return 'Interns Management';
      case 3:
        return 'Schools Management';
      default:
        return 'My App';
    }
  }

  List<Widget> _pageOption = <Widget>[
    FirstPageOfHome(),
    supervisorPage(),
    internScreen(),
    instituteScreen(),
    widgetDrawer(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.i != null) {
      setState(() {
        _selectedIndex = widget.i;
      });
    }
  }

  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: AppBar(
            backgroundColor: Colors.black87,
            actions: [
              IconButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/');
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('token');
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
              ),
            ],
            centerTitle: true,
            title: Text(
              _getPageTitle(_selectedIndex),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        drawer: widgetDrawer(),
        body: Center(
          child: _pageOption.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              padding: EdgeInsets.all(3),
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Supervisor',
                ),
                GButton(
                  icon: Icons.hail,
                  text: 'Intern',
                ),
                GButton(
                  icon: Icons.school_rounded,
                  text: 'School',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
