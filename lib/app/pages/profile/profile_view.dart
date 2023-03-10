import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/app/pages/salon_dashboard/salon_dashboard_view.dart';
import 'package:salon_app/app/pages/salon_signup/salon_signup_view.dart';
import 'package:salon_app/app/widgets/app_bottom_navigation_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void handleStart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SalonSignupView(),
      ),
    );
  }

  void handleSalon() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SalonDashboardView(),
      ),
    );
  }

  void handleLogout() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFD9ED),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 56.0),
                  AppElevatedButton(
                    onPressed: handleStart,
                    child: const Text(
                      "Start your Salon's Journey",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  AppElevatedButton(
                    onPressed: handleSalon,
                    child: const Text(
                      'Your Salon',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  AppElevatedButton(
                    onPressed: handleLogout,
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationItemsIndexed['profile'] as int,
      ),
    );
  }
}
