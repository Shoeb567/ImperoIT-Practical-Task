import 'package:flutter/material.dart';

Widget appBarIcon({IconData? iconData,VoidCallback? onTap}){
  return IconButton(
    icon: Icon(
      iconData,
      color: Colors.white,
    ),
    onPressed: onTap,
  );
}