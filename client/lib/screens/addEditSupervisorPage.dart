import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/imagePicker.dart';
import '../components/showCustom.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'homePage.dart';

class addEditSupervisorPage extends StatefulWidget {
  var Wfirstname;
  var WLastname;
  var Wemail;
  var WPhonenumber;
  var Wmatricule;
  var WworkStation;

  var pageType;
  var Wid;

  addEditSupervisorPage(
      {this.pageType,
      this.Wemail,
      this.Wfirstname,
      this.WLastname,
      this.Wmatricule,
      this.WPhonenumber,
      this.WworkStation,
      this.Wid});

  @override
  State<addEditSupervisorPage> createState() => _addEditSupervisorPageState();
}

class _addEditSupervisorPageState extends State<addEditSupervisorPage> {
  //--------------------------------
  late File picture;
  File? pic;

  late bool errText = false;
  //--------------------------------
  late String firstname = '';
  late String Lastname = '';
  late String email = '';
  late String Phonenumber = '';
  late String matricule = '';
  late String workStation = '';

  EditFiller() {
    firstname = widget.Wfirstname;
    Lastname = widget.WLastname;
    email = widget.Wemail;
    Phonenumber = widget.WPhonenumber;
    matricule = widget.Wmatricule;
    workStation = widget.WworkStation;
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.pageType == "Edit") {
      EditFiller();
    }
  }

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      print("hey");
    } else {
      picture = File(image!.path);
      final imageTepmorary = File(image.path);
      setState(() {
        this.pic = imageTepmorary;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: widget.pageType == "Edit"
              ? Text('Edit ${widget.Wfirstname} ${widget.WLastname}')
              : Text('Add a new supervisor'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Scaffold(
            body: Container(
              alignment: Alignment.center,
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.black38],
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: widget.pageType == 'Edit' ? false : true,
                        child: ProfileWidget(
                          onClicked: () {
                            pickImage();
                          },
                          imagee: pic,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: TextEditingController()
                                  ..text = firstname,
                                onChanged: (value) {
                                  firstname = value;
                                },
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                                decoration: InputDecoration(
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 45),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                    size: 22,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Firstname',
                                  hintStyle: TextStyle(
                                      color: Colors.white60, fontSize: 14.5),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: TextEditingController()
                                  ..text = Lastname,
                                onChanged: (value) {
                                  Lastname = value;
                                },
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                                decoration: InputDecoration(
                                  prefixIconConstraints:
                                      BoxConstraints(minWidth: 45),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                    size: 22,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Lastname',
                                  hintStyle: TextStyle(
                                      color: Colors.white60, fontSize: 14.5),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Colors.white38)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    borderSide:
                                        BorderSide(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30)
                            .copyWith(bottom: 10),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: TextEditingController()..text = email,
                          onChanged: (value) {
                            email = value;
                          },
                          style: TextStyle(color: Colors.white, fontSize: 14.5),
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 45),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white70,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white38)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white70))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)
                            .copyWith(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextField(
                                maxLength: 8,
                                controller: TextEditingController()
                                  ..text = Phonenumber,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  Phonenumber = value;
                                },
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                                decoration: InputDecoration(
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 45),
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Colors.white70,
                                      size: 22,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Phone number',
                                    hintStyle: TextStyle(
                                        color: Colors.white60, fontSize: 14.5),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide:
                                            BorderSide(color: Colors.white38)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide:
                                            BorderSide(color: Colors.white70))),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextField(
                                maxLength: 8,
                                controller: TextEditingController()
                                  ..text = matricule,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  matricule = value;
                                },
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.5),
                                decoration: InputDecoration(
                                    prefixIconConstraints:
                                        BoxConstraints(minWidth: 45),
                                    prefixIcon: Icon(
                                      Icons.numbers,
                                      color: Colors.white70,
                                      size: 22,
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Matricule',
                                    hintStyle: TextStyle(
                                        color: Colors.white60, fontSize: 14.5),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide:
                                            BorderSide(color: Colors.white38)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide:
                                            BorderSide(color: Colors.white70))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30)
                            .copyWith(bottom: 10),
                        child: TextField(
                          controller: TextEditingController()
                            ..text = workStation.toString(),
                          onChanged: (value) {
                            workStation = value;
                          },
                          style: TextStyle(color: Colors.white, fontSize: 14.5),
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 45),
                              prefixIcon: Icon(
                                Icons.work,
                                color: Colors.white70,
                                size: 22,
                              ),
                              border: InputBorder.none,
                              hintText: 'Work Station',
                              hintStyle: TextStyle(
                                  color: Colors.white60, fontSize: 14.5),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white38)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide:
                                      BorderSide(color: Colors.white70))),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (email.isEmpty ||
                              email == ' ' ||
                              firstname.isEmpty ||
                              firstname == ' ' ||
                              Lastname.isEmpty ||
                              Lastname == ' ' ||
                              Phonenumber.isEmpty ||
                              Phonenumber == ' ' ||
                              matricule == '' ||
                              matricule.isEmpty ||
                              workStation.isEmpty ||
                              workStation == ' ') {
                            setState(() {
                              errText = true;
                            });
                          } else {
                            setState(() {
                              errText = false;
                            });
                            var data = {
                              "firstName": firstname,
                              "lastName": Lastname,
                              "email": email,
                              "phoneNumber": Phonenumber,
                              "workStation": workStation,
                              "matricule": matricule,
                            };
                            var encodedData = jsonEncode(data);
                            if (widget.pageType == "Edit") {
                              try {
                                http.Response res = await http.patch(
                                    Uri.parse(
                                        '$Kurl/api/v1/supervisors/updatesupervisor/${widget.Wid}'),
                                    headers: {
                                      'Content-Type':
                                          'application/json; charset=UTF-8',
                                    },
                                    body: encodedData);
                                if (res.statusCode == 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => homePage(i: 1),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      padding: EdgeInsets.all(13),
                                      backgroundColor: Color(0xffFFE699),
                                      content: Text(
                                        'Supervisor Edited succefully',
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              } catch (err) {
                                print("this is $err");
                              }
                            } else {
                              try {
                                var request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                      "$Kurl/api/v1/supervisors/createsupervisor"),
                                );
                                request.fields['firstName'] =
                                    firstname.toString();
                                request.fields['lastName'] =
                                    Lastname.toString();
                                request.fields['email'] = email.toString();
                                request.fields['phoneNumber'] =
                                    Phonenumber.toString();
                                request.fields['workStation'] =
                                    workStation.toString();
                                request.fields['matricule'] =
                                    matricule.toString();
                                request.files.add(http.MultipartFile.fromBytes(
                                    'picture',
                                    File(picture!.path).readAsBytesSync(),
                                    filename: picture!.path));
                                var res = await request.send();

                                if (res.statusCode == 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => homePage(i: 1),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      padding: EdgeInsets.all(13),
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        'Supervisor added succefully',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              } catch (err) {
                                print(err);
                              }
                            }
                          }
                        },
                        child: Container(
                          height: 53,
                          width: 300,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white60),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: widget.pageType == "Edit"
                              ? Text('Edit !',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  'Add !',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(.8),
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Visibility(
                        visible: errText,
                        child: Text(
                          "You have to fill all the fields !",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
