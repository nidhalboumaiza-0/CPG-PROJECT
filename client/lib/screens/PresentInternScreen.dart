import 'package:client/API/getInternAbsences.dart';
import 'package:client/API/getInternDataApi.dart';
import 'package:client/models/internModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../components/intern Components/NonAffectedInternStreamBuilder.dart';
import '../components/intern Components/StremBuilderPresentPage.dart';
import '../models/instituteModel.dart';

late Stream<List<Intern>> StreamAffectedIntern;
List resultsIntern = [];
List<Intern> streamingInt = [];

class PresentInternScreen extends StatefulWidget {
  const PresentInternScreen({Key? key}) : super(key: key);

  @override
  State<PresentInternScreen> createState() => _PresentInternScreenState();
}

class _PresentInternScreenState extends State<PresentInternScreen> {
  late Stream<List<Institute>> institutes;

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
  //         StreamInternNonAffected = convertToStream(streamingInt);
  //       });
  //     } else {
  //       setState(() {
  //         StreamInternNonAffected = convertToStream(streamingInt);
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       StreamInternNonAffected = getAllInterns('/getnonaffectedintern');
  //     });
  //   }
  // }

  Stream<List<Intern>> convertToStream(List<Intern> stream) async* {
    yield stream;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    StreamAffectedIntern = getAllInterns('/getaffectedintern');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Affected interns',
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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 5, right: 15),
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
                            "Management Of Affected interns",
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
                        'Affected Interns :',
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
                  child: StreamBuilderPresentPage(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
