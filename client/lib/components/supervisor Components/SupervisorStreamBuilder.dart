import 'package:client/components/showCustom.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import '../roundedButton.dart';
import '../../constants.dart';
import '../../screens/addEditSupervisorPage.dart';
import '../../screens/homePage.dart';
import '../../screens/supervisorPage.dart';
import '../../models/sepervisorModel.dart';

class supervisorFuture extends StatelessWidget {
  const supervisorFuture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Supervisor>>(
      stream: StreamSupervisors,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 128,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 9,
                          left: 9,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueGrey.withOpacity(0.8),
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: Ink.image(
                                  image: AssetImage(
                                          'images/${snapshot.data![index].picture}')
                                      as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: 106,
                                  height: 106,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 120,
                          child: Text(
                            "${snapshot.data![index].firstName} ${snapshot.data![index].lastName}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 120,
                          child: Row(
                            children: [
                              Text(
                                "Matricule: ",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "${snapshot.data![index].matricule}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 65,
                          left: 120,
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 12,
                              ),
                              Text(
                                " ${snapshot.data![index].email}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 120,
                          child: Row(
                            children: [
                              Text(
                                "Intern's number:",
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                " ${snapshot.data![index].internNumber}",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 280,
                          child: RoundIconButton(
                            colour: Color(0xffFFE699),
                            icon: Icons.edit,
                            onPressAction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => addEditSupervisorPage(
                                    pageType: "Edit",
                                    Wemail: snapshot.data![index].email,
                                    Wfirstname: snapshot.data![index].firstName,
                                    WLastname: snapshot.data![index].lastName,
                                    Wmatricule: snapshot.data![index].matricule,
                                    WPhonenumber:
                                        snapshot.data![index].phoneNumber,
                                    WworkStation:
                                        snapshot.data![index].workStation,
                                    Wid: snapshot.data![index].id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 70,
                          left: 280,
                          child: RoundIconButton(
                            colour: Color(0xffECC1C6),
                            icon: Icons.delete,
                            onPressAction: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete"),
                                    content: Text(
                                        "Do you really want to delete ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          try {
                                            http.Response res =
                                                await http.delete(
                                              Uri.parse(
                                                  "$Kurl/api/v1/supervisors/deletesupervisor/${snapshot.data![index].id}"),
                                              headers: {
                                                'Content-Type':
                                                    'application/json; charset=UTF-8',
                                              },
                                            );
                                            if (res.statusCode == 200) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      homePage(i: 1),
                                                ),
                                              );
                                              showCustom(context, "delete");
                                            }
                                          } catch (err) {
                                            print(err);
                                          }
                                        },
                                        child: Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1.5,
                    indent: 2,
                    endIndent: 2,
                  ),
                  SizedBox(
                    height: 8,
                  )
                ],
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
      },
    );
  }
}

//-------------------------------------------
// return GridView.builder(
// physics: NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// crossAxisSpacing: 12,
// mainAxisSpacing: 12,
// mainAxisExtent: 270,
// ),
// itemCount: snapshot.data!.length,
// itemBuilder: (context, index) {
// return Container(
// height: 50,
// width: 50,
// decoration: BoxDecoration(
// color: Colors.white.withOpacity(0.7),
// borderRadius: BorderRadius.circular(10),
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.only(top: 8.0),
// child: Center(
// child: CircleAvatar(
// radius: 40,
// backgroundColor: Colors.white.withOpacity(0.5),
// child: ClipOval(
// child: SizedBox(
// height: 77,
// child: Image(
// fit: BoxFit.fill,
// image: AssetImage('images/nidhal.jpg'),
// ),
// ),
// ),
// ),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Center(
// child: Text(
// '${snapshot.data![index].firstName} ${snapshot.data![index].lastName}'),
// ),
// SizedBox(
// height: 15,
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 8.0),
// child: Text(' Work station : '),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0, left: 8),
// child: Text(' ${snapshot.data![index].workStation} '),
// ),
// SizedBox(
// height: 8,
// ),
// Center(
// child: Text(
// 'Interns : ${snapshot.data![index].internNumber}'),
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Flexible(
// child: RoundIconButton(
// colour: Color(0xffFFE699),
// icon: Icons.edit,
// onPressAction: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => addEditSupervisorPage(
// pageType: "Edit",
// Wemail: snapshot.data![index].email,
// Wfirstname: snapshot.data![index].firstName,
// WLastname: snapshot.data![index].lastName,
// Wmatricule: snapshot.data![index].matricule,
// WPhonenumber:
// snapshot.data![index].phoneNumber,
// WworkStation:
// snapshot.data![index].workStation,
// Wid: snapshot.data![index].id,
// ),
// ),
// );
// },
// ),
// ),
// SizedBox(
// width: 16,
// ),
// Flexible(
// child: RoundIconButton(
// colour: Color(0xffECC1C6),
// icon: Icons.delete,
// onPressAction: () {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return AlertDialog(
// title: Text("Delete"),
// content: Text(
// "Do you really want to delete ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}"),
// actions: [
// FlatButton(
// onPressed: () async {
// Navigator.pop(context);
// },
// child: Text("Cancel"),
// ),
// FlatButton(
// onPressed: () async {
// try {
// http.Response res =
// await http.delete(
// Uri.parse(
// "$Kurl/api/v1/supervisors/deletesupervisor/${snapshot.data![index].id}"),
// headers: {
// 'Content-Type':
// 'application/json; charset=UTF-8',
// },
// );
// if (res.statusCode == 200) {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// homePage(i: 1),
// ),
// );
// showCustom(context, "delete");
// }
// } catch (err) {
// print(err);
// }
// },
// child: Text("Delete"),
// ),
// ],
// );
// },
// );
// },
// ),
// ),
// ],
// )
// ],
// ),
// );
// },
// );
