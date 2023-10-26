
import 'dart:math';

import 'package:flutter/material.dart';

class CustomNote extends StatelessWidget {
  const CustomNote({super.key, required this.title, required this.subtitle, this.onTap});
  final String title;
  final String subtitle;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    List<Color> colors = [const Color.fromARGB(255, 190, 51, 41),const Color.fromARGB(255, 9, 112, 197),Colors.amber,const Color.fromARGB(255, 224, 109, 245)];
    var random = Random();
    var coloor = colors[random.nextInt(colors.length)];
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: coloor,
          borderRadius: BorderRadius.circular(25)
        ),
        child: ListTile(
          title:Text(title) ,
          trailing: GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.done)) ,
          subtitle:Text(subtitle) ,
        ),
      ),
    );
  }
}