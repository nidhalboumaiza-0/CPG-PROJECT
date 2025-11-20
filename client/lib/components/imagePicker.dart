import 'dart:io';

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final File? imagee;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagee,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            left: 100,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: imagee != null
              ? FileImage(imagee!)
              : AssetImage('images/person.jpg') as ImageProvider,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onClicked,
            child: buildCircle(
              color: color,
              all: 8,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      );

  Widget buildCircle(
          {required Widget child,
          required double all,
          required Color color,
          required}) =>
      ClipOval(
        child: Material(
          child: Container(
            padding: EdgeInsets.all(all),
            color: color,
            child: child,
          ),
        ),
      );
}
