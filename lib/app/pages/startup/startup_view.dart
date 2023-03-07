import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:salon_app/app/pages/discovery/discovery_view.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const DiscoveryView(),
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFD9ED),
        child: const Center(
          child: Image(
            image: AssetImage('assets/images/app_logo.png'),
          ),
        ),
      ),
    );
  }
}
