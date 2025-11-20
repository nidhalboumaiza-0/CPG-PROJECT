import 'package:client/API/getInstituteDataApi.dart';
import 'package:client/API/getInternDataApi.dart';
import 'package:client/models/internModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/imagePicker.dart';
import '../components/intern Components/InternStreamBuilder.dart';
import '../constants.dart';
import '../models/instituteModel.dart';
import 'homePage.dart';

late dynamic dataIntern;
late Stream<List<Intern>> StreamIntern;
List resultsIntern = [];
String chhh = '';
List<Intern> streamingInt = [];
var picture;

class internScreen extends StatefulWidget {
  const internScreen({Key? key}) : super(key: key);

  @override
  State<internScreen> createState() => _internScreenState();
}

class _internScreenState extends State<internScreen> {
  late File picture;
  File? pic;
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
    setState(() {});
  }

  late Stream<List<Institute>> institutes;

  late String id = '';
  late String firstName = '';
  late String lastName = '';
  late String email = '';
  late String phoneNumber = '';
  late String cin = '';
  late String genre = '';
  late String institute = '';

  late String _ErrorfirstName = '';
  late String _ErrorlastName = '';
  late String _Erroremail = '';
  late String _ErrorphoneNumber = '';
  late String _Errorcin = '';

  bool? status;
  bool? affected;
  String _gendre = "Male";
  // void runFiller(String enteredKeyword) {
  //   if (enteredKeyword.isNotEmpty) {
  //     Intern ss = Intern();
  //     resultsIntern = [];
  //     resultsIntern = toFetchListIntern
  //         .where((o) => o['firstName']
  //             .toLowerCase()
  //             .contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     streamingInt = [];
  //     if (resultsIntern.length >= 1) {
  //       for (var index = 0; index < resultsIntern.length; index++) {
  //         ss = Intern(
  //           id: resultsIntern[index]["_id"],
  //           firstName: resultsIntern[index]["firstName"],
  //           lastName: resultsIntern[index]["lastName"],
  //           email: resultsIntern[index]["email"],
  //           phoneNumber: resultsIntern[index]["phoneNumber"],
  //           cin: resultsIntern[index]["cin"],
  //           genre: resultsIntern[index]["genre"],
  //           instituteName: resultsIntern[index]["institute"]["name"],
  //           instituteId: resultsIntern[index]["institute"]["_id"],
  //         );
  //
  //         if (ss != null) {
  //           streamingInt.add(ss);
  //         }
  //       }
  //       setState(() {
  //         StreamIntern = convertToStream(streamingInt);
  //       });
  //     } else {
  //       setState(() {
  //         StreamIntern = convertToStream(streamingInt);
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       StreamIntern = getAllInterns();
  //     });
  //   }
  // }

  Stream<List<Intern>> convertToStream(List<Intern> stream) async* {
    yield stream;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    StreamIntern = getAllInterns('/');
    genre = 'Male';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: FloatingActionButton(
            onPressed: () {
              institutes = getAllInstitutes();
              showDialog(
                context: context,
                builder: (BuildContext) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        title: Text('Add Intern'),
                        content: SingleChildScrollView(
                          child: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  StatefulBuilder(
                                    builder: (context, setState) {
                                      return ProfileWidget(
                                        onClicked: () async {
                                          await pickImage();
                                          setState(() {});
                                        },
                                        imagee: pic,
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('FirstName :'),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'FirstName',
                                            errorText: _ErrorfirstName.isEmpty
                                                ? null
                                                : _ErrorfirstName),
                                    onChanged: (value) {
                                      firstName = value;
                                      setState(() {
                                        _ErrorfirstName = '';
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Lastname :'),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    onChanged: (value) {
                                      lastName = value;
                                      setState(() {
                                        _ErrorlastName = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Lastname',
                                            errorText: _ErrorlastName.isEmpty
                                                ? null
                                                : _ErrorlastName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Institute :'),
                                      ],
                                    ),
                                  ),
                                  StreamBuilder<List<Institute>>(
                                    stream: institutes,
                                    builder: (context, snapshot1) {
                                      if (!snapshot1.hasData) {
                                        return Text('there is no institute');
                                      } else {
                                        institute = snapshot1.data![0].id!;
                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return StatefulBuilder(
                                              builder: (context,
                                                  void Function(void Function())
                                                      setState) {
                                                return DropdownButton(
                                                  value: institute,
                                                  icon: Icon(Icons
                                                      .keyboard_arrow_down),
                                                  items: [
                                                    for (var i = 0;
                                                        i <
                                                            snapshot1
                                                                .data!.length;
                                                        i++)
                                                      DropdownMenuItem(
                                                        value: snapshot1
                                                            .data![i].id,
                                                        child: Text(
                                                            "${snapshot1.data![i].name}"),
                                                      )
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      institute =
                                                          value.toString();
                                                      print(value);
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Email :'),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (value) {
                                      email = value;
                                      setState(() {
                                        _Erroremail = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Email',
                                            errorText: _ErrorlastName.isEmpty
                                                ? null
                                                : _ErrorlastName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Phone number :'),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    maxLength: 8,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      phoneNumber = value;
                                      setState(() {
                                        _ErrorphoneNumber = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Phone number',
                                            errorText: _ErrorlastName.isEmpty
                                                ? null
                                                : _ErrorlastName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Cin :'),
                                      ],
                                    ),
                                  ),
                                  TextField(
                                    maxLength: 8,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      cin = value;
                                      setState(() {
                                        _Errorcin = '';
                                      });
                                    },
                                    decoration:
                                        KinputDecorationInstitue.copyWith(
                                            hintText: 'Cin',
                                            errorText: _ErrorlastName.isEmpty
                                                ? null
                                                : _ErrorlastName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '(*) ',
                                          style: TextStyle(
                                            color: Color(0xffDC3545),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text('Genre :'),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Male'),
                                      Radio(
                                        value: "Male",
                                        groupValue: _gendre,
                                        onChanged: (value) {
                                          setState(() {
                                            _gendre = value.toString();
                                            genre = value.toString();
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(''
                                          'Female'),
                                      Radio(
                                        value: "Female",
                                        groupValue: _gendre,
                                        onChanged: (value) {
                                          setState(() {
                                            _gendre = value.toString();
                                            genre = value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (firstName.isEmpty ||
                                                  firstName == ' ') {
                                                _ErrorfirstName =
                                                    "Please provide your Email .";
                                              } else {
                                                _ErrorfirstName = '';
                                              }
                                              if (lastName.isEmpty ||
                                                  lastName == ' ') {
                                                _ErrorlastName =
                                                    "Please provide your Email .";
                                              } else {
                                                _ErrorlastName = '';
                                              }
                                              if (email.isEmpty ||
                                                  email == ' ') {
                                                _Erroremail =
                                                    "Please provide your Email .";
                                              } else {
                                                _Erroremail = '';
                                              }
                                              if (phoneNumber.isEmpty ||
                                                  email == ' ') {
                                                _ErrorphoneNumber =
                                                    "Please provide your Email .";
                                              } else {
                                                _ErrorphoneNumber = '';
                                              }
                                              if (cin.isEmpty || cin == ' ') {
                                                _Errorcin =
                                                    "Please provide your Email .";
                                              } else {
                                                _Errorcin = '';
                                              }
                                            });
                                            var request = http.MultipartRequest(
                                              'POST',
                                              Uri.parse(
                                                  "$Kurl/api/v1/interns/createintern/"),
                                            );
                                            request.fields['firstName'] =
                                                firstName.toString();
                                            request.fields['lastName'] =
                                                lastName.toString();
                                            request.fields['email'] =
                                                email.toString();
                                            request.fields['phoneNumber'] =
                                                phoneNumber.toString();
                                            request.fields['genre'] =
                                                genre.toString();
                                            request.fields['cin'] =
                                                cin.toString();
                                            request.fields['institute'] =
                                                institute.toString();
                                            request.files.add(
                                                http.MultipartFile.fromBytes(
                                                    'picture',
                                                    File(picture!.path)
                                                        .readAsBytesSync(),
                                                    filename: picture!.path));
                                            var res = await request.send();

                                            if (res.statusCode == 201) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      homePage(i: 2),
                                                ),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  padding: EdgeInsets.all(13),
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Intern added succefully',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          height: 40,
                                          minWidth: 80,
                                          color: Color(0xffBCE29E),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Add',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          elevation: 3,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            _Errorcin = '';
                                            _ErrorphoneNumber = '';
                                            _Erroremail = '';
                                            _ErrorlastName = '';
                                            _ErrorfirstName = '';
                                            Navigator.pop(context);
                                          },
                                          height: 40,
                                          minWidth: 80,
                                          color: Color(0xffECC1C6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
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
            child: Icon(Icons.add),
            backgroundColor: Color(0xffA5AAB7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 20, right: 15),
                  height: 60,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Intern',
                        style: TextStyle(
                          color: Color(0xffCCCFD4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Management Of interns",
                            style: TextStyle(
                                color: Color(0xff171D5F),
                                fontWeight: FontWeight.w900),
                          ),
                          Icon(
                            Icons.hail,
                            color: Color(0xffA5AAB7),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    onChanged: (value) {
                      //runFiller(value);
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffA5AAB7), width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      hintText: 'Search for intern',
                      hintStyle: TextStyle(fontSize: 15),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xffA5AAB7),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Flexible(
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        'Interns :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff171D5F),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1.5,
                  indent: 18,
                  endIndent: 18,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: internStream(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
