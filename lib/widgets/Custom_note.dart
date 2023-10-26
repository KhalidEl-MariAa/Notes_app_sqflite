

import 'package:flutter/material.dart';

class CustomNote extends StatelessWidget {
  const CustomNote({super.key, required this.title, required this.subtitle, this.onTap});
  final String title;
  final String subtitle;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        decoration: BoxDecoration(
          color: Colors.amber[600],
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