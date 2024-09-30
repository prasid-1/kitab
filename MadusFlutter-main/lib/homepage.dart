import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String text = "Hello";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
