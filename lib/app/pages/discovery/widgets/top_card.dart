import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key,this.urlLogo});
  final String? urlLogo;


  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        width: 156.0,
        height: 128.0,
        decoration: const BoxDecoration(
          color: Color(0xFFC93480),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Image.network(urlLogo!),
      ),
    );
  }
}
