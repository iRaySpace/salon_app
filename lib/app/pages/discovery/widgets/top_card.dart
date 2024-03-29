import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({
    super.key,
    required this.salonName,
    this.urlLogo,
    this.onTap,
  });
  final String salonName;
  final String? urlLogo;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Container(
          width: 156.0,
          padding: const EdgeInsets.only(top: 15.0),
          decoration: const BoxDecoration(
            color: Color(0xFFC93480),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(64.0), // Image radius
                  child: Image.network(urlLogo!, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                salonName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
