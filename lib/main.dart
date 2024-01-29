import 'package:flutter/material.dart';
import 'package:maps/widgets/googleMap.dart';

void main() {
  runApp(const map());
}

class map extends StatelessWidget {
  const map({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: googlemap()
    );
  }
}
