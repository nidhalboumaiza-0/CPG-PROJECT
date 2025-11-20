// child: MaterialButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (BuildContext) {
// return AlertDialog(
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(
// Radius.circular(20.0),
// ),
// ),
// title: Text(
// '${snapshot.data![index].firstName} ${snapshot.data![index].lastName}',
// style: TextStyle(
// color: Color(0xFF3490CC)),
// ),
// content: Container(
// height: 140,
// width: 310,
// margin: EdgeInsets.fromLTRB(
// 0, 0, 10, 0),
// decoration: BoxDecoration(
// color: Color(0xFFFFFFFF),
// ),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: <Widget>[
// Expanded(
// child: Column(
// children: <Widget>[
// Row(
// children: [
// Icon(
// Icons.school,
// color: Color(
// 0xFF3490CC),
// size: 20,
// ),
// Padding(
// padding: EdgeInsets
//     .fromLTRB(
// 7, 0, 0, 0),
// child: Flexible(
// child: Text(
// "${snapshot.data![index].instituteName}",
// style:
// TextStyle(
// color: Colors
//     .black,
// fontFamily:
// 'Dubai',
// ),
// ),
// ),
// ),
// ],
// ),
// SizedBox(
// height: 15,
// ),
// Row(
// children: [
// Icon(
// Icons.email,
// color: Color(
// 0xFF3490CC),
// size: 20,
// ),
// Padding(
// padding: EdgeInsets
//     .fromLTRB(
// 7, 0, 0, 0),
// child: Text(
// "${snapshot.data![index].email}",
// style: TextStyle(
// color: Colors
//     .black,
// fontFamily:
// 'Dubai',
// ),
// ),
// ),
// ],
// ),
// SizedBox(
// height: 15,
// ),
// Row(
// children: [
// Icon(
// Icons.phone_rounded,
// color: Color(
// 0xFF3490CC),
// size: 20,
// ),
// Padding(
// padding: EdgeInsets
//     .fromLTRB(
// 7, 0, 0, 0),
// child: Text(
// "${snapshot.data![index].phoneNumber}",
// style: TextStyle(
// color: Colors
//     .black,
// fontFamily:
// 'Dubai',
// ),
// ),
// ),
// ],
// ),
// SizedBox(
// height: 15,
// ),
// Row(
// children: [
// Icon(
// Icons
//     .perm_identity_rounded,
// color: Color(
// 0xFF3490CC),
// size: 20,
// ),
// Padding(
// padding: EdgeInsets
//     .fromLTRB(
// 7, 0, 0, 0),
// child: Text(
// "${snapshot.data![index].cin}",
// style: TextStyle(
// color: Colors
//     .black,
// fontFamily:
// 'Dubai',
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// )
// ],
// ),
// ),
// );
// });
// },
// height: 40,
// minWidth: 80,
// color: Color(0xffC9F4AA),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.all(
// Radius.circular(10.0),
// ),
// ),
// child: Text(
// 'More info',
// style: TextStyle(
// fontSize: 14,
// fontWeight: FontWeight.bold,
// ),
// ),
// elevation: 3,
// ),
