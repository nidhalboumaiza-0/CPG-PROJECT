import 'package:client/models/internModel.dart';
import 'package:client/screens/internersPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../API/getInstituteDataApi.dart';
import '../../constants.dart';
import '../../models/instituteModel.dart';
import '../../screens/homePage.dart';
import '../roundedButton.dart';
import '../showCustom.dart';

List toFetchListIntern = [];

class internStream extends StatefulWidget {
  const internStream({Key? key}) : super(key: key);

  @override
  State<internStream> createState() => _internStreamState();
}

class _internStreamState extends State<internStream> {
  late Stream<List<Institute>> institutes;
  late String id = '';
  late String firstName = '';
  late String lastName = '';
  late String email = '';
  late String phoneNumber = '';
  late String cin = '';
  late String genre = '';
  late String institute = '';
  late String _gendre = '';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Intern>>(
      stream: StreamIntern,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text("The stream is null .");
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );

          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.18,
                          maxHeight: double.infinity,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.01,
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
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.017,
                              left: MediaQuery.of(context).size.width * 0.32,
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
                              left: MediaQuery.of(context).size.width * 0.32,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.email_rounded,
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
                              left: MediaQuery.of(context).size.width * 0.32,
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.school_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    " ${snapshot.data![index].instituteName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 65,
                              left: MediaQuery.of(context).size.width * 0.32,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    size: 15,
                                  ),
                                  Text(
                                    " ${snapshot.data![index].phoneNumber}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.width * 0.8,
                              child: RoundIconButton(
                                colour: Color(0xffFFE699),
                                icon: Icons.edit,
                                onPressAction: () {
                                  firstName = snapshot.data![index].firstName!;
                                  lastName = snapshot.data![index].lastName!;
                                  phoneNumber =
                                      snapshot.data![index].phoneNumber!;
                                  email = snapshot.data![index].email!;
                                  cin = snapshot.data![index].cin!;
                                  institutes = getAllInstitutes();
                                  _gendre = snapshot.data![index].genre!;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext) {
                                      return StatefulBuilder(
                                        builder: (buildcontext,
                                            StateSetter setState) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30.0),
                                              ),
                                            ),
                                            title: Text(
                                                'Edit ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}'),
                                            content: SingleChildScrollView(
                                              child: Wrap(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child:
                                                            Text('Firstname :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = snapshot
                                                                    .data![
                                                                        index]
                                                                    .firstName!,
                                                          onChanged: (value) {
                                                            firstName = value;
                                                          },
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                                      hintText:
                                                                          'Name'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child:
                                                            Text('Lastname :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          controller:
                                                              TextEditingController()
                                                                ..text = snapshot
                                                                    .data![
                                                                        index]
                                                                    .lastName!,
                                                          onChanged: (value) {
                                                            lastName = value;
                                                          },
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                                      hintText:
                                                                          'Lastname'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text(
                                                            'Phone number :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              TextEditingController()
                                                                ..text = snapshot
                                                                    .data![
                                                                        index]
                                                                    .phoneNumber!,
                                                          onChanged: (value) {
                                                            phoneNumber = value;
                                                          },
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                            hintText:
                                                                'Phone number',
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text('Email :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .emailAddress,
                                                          controller:
                                                              TextEditingController()
                                                                ..text = snapshot
                                                                    .data![
                                                                        index]
                                                                    .email!,
                                                          onChanged: (value) {
                                                            email = value;
                                                          },
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                                      hintText:
                                                                          'Email'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text('Cin :'),
                                                      ),
                                                      Container(
                                                        height: 50,
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              TextEditingController()
                                                                ..text = snapshot
                                                                    .data![
                                                                        index]
                                                                    .cin!,
                                                          onChanged: (value) {
                                                            cin = value;
                                                          },
                                                          decoration:
                                                              KinputDecorationInstitue
                                                                  .copyWith(
                                                            hintText: 'Cin',
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child: Text('Gender :'),
                                                      ),
                                                      // RADIO BUTTONé

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text('Male'),
                                                          Radio(
                                                            value: "Male",
                                                            groupValue: _gendre,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _gendre = value
                                                                    .toString();
                                                                genre = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text('Female'),
                                                          Radio(
                                                            value: "Female",
                                                            groupValue: _gendre,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _gendre = value
                                                                    .toString();
                                                                genre = value
                                                                    .toString();
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 8.0,
                                                                top: 8),
                                                        child:
                                                            Text('Institue :'),
                                                      ),
                                                      StatefulBuilder(
                                                        builder: (context,
                                                            void Function(
                                                                    void
                                                                        Function())
                                                                setState) {
                                                          return StreamBuilder<
                                                              List<Institute>>(
                                                            stream: institutes,
                                                            builder: (context,
                                                                snapshot1) {
                                                              if (!snapshot1
                                                                  .hasData) {
                                                                return Text(
                                                                    'there is no institur');
                                                              } else {
                                                                institute = snapshot
                                                                    .data![
                                                                        index]
                                                                    .instituteId!;
                                                                return StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                    return DropdownButton(
                                                                      value:
                                                                          institute,
                                                                      icon: Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down),
                                                                      items: [
                                                                        for (var i =
                                                                                0;
                                                                            i < snapshot1.data!.length;
                                                                            i++)
                                                                          DropdownMenuItem(
                                                                            value:
                                                                                snapshot1.data![i].id,
                                                                            child:
                                                                                Text("${snapshot1.data![i].name}"),
                                                                          )
                                                                      ],
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          institute =
                                                                              value.toString();
                                                                        });
                                                                      },
                                                                      //value: snapshot1.data![0].name,
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 5,
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed:
                                                                  () async {
                                                                var data = {
                                                                  "firstName":
                                                                      firstName,
                                                                  "lastName":
                                                                      lastName,
                                                                  "email":
                                                                      email,
                                                                  "phoneNumber":
                                                                      phoneNumber,
                                                                  "cin": cin,
                                                                  "genre":
                                                                      genre,
                                                                  "institute":
                                                                      institute
                                                                };

                                                                var encodedData =
                                                                    jsonEncode(
                                                                        data);
                                                                http.Response
                                                                    res =
                                                                    await http.patch(
                                                                        Uri.parse(
                                                                            '$Kurl/api/v1/interns/updateintern/${snapshot.data![index].id}'),
                                                                        headers: {
                                                                          'Content-Type':
                                                                              'application/json; charset=UTF-8',
                                                                        },
                                                                        body:
                                                                            encodedData);

                                                                if (res.statusCode ==
                                                                    200) {
                                                                  print(res);
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          homePage(
                                                                              i: 2),
                                                                    ),
                                                                  );
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      behavior:
                                                                          SnackBarBehavior
                                                                              .floating,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              13),
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xffFFE699),
                                                                      content:
                                                                          Text(
                                                                        'Intern edited succefully',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black87,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                              height: 40,
                                                              minWidth: 80,
                                                              color: Color(
                                                                  0xffFFE699),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Edit',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              elevation: 3,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: 5,
                                                            ),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              height: 40,
                                                              minWidth: 80,
                                                              color: Color(
                                                                  0xffECC1C6),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'Cancel',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              elevation: 3,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.09,
                              left: MediaQuery.of(context).size.width * 0.8,
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
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Delete"),
                                                    content: Text(
                                                        "Do you really want to delete ${snapshot.data![index].firstName} ${snapshot.data![index].lastName}"),
                                                    actions: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          print(snapshot
                                                              .data![index]
                                                              .supervisorId);
                                                          try {
                                                            var data = {
                                                              "idSupervisor":
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .supervisorId,
                                                            };
                                                            var encodedData =
                                                                jsonEncode(
                                                                    data);
                                                            http.Response res =
                                                                await http
                                                                    .delete(
                                                              Uri.parse(
                                                                  "$Kurl/api/v1/interns/deleteintern/${snapshot.data![index].id}"),
                                                              headers: {
                                                                'Content-Type':
                                                                    'application/json; charset=UTF-8',
                                                              },
                                                              body: encodedData,
                                                            );
                                                            if (res.statusCode ==
                                                                200) {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      homePage(
                                                                          i: 2),
                                                                ),
                                                              );
                                                              showCustom(
                                                                  context,
                                                                  "deleteI");
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
                                            child: Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width * 0.32,
                                    MediaQuery.of(context).size.height * 0.148,
                                    0,
                                    0),
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: snapshot.data![index].affected ==
                                              false
                                          ? Color(0xffFF6464)
                                          : Color(0xff59CE8F),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: snapshot.data![index].affected == false
                                      ? Text(
                                          'Not affected',
                                          style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      : Text(
                                          'affected',
                                          style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                ),
                              ),
                            )
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
              return Text(
                  "the stream has no data maybe there is an error on the API.");
            }
          default:
            return Text('Non intern exist.');
        }
      },
    );
  }
}
