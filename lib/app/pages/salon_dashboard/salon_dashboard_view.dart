import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/app/pages/salon_dashboard/widgets/dashboard_card.dart';

class SalonDashboardView extends StatefulWidget {
  const SalonDashboardView({super.key});

  @override
  State<SalonDashboardView> createState() => _SalonDashboardViewState();
}

class _SalonDashboardViewState extends State<SalonDashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFD9ED),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 56.0),
                const SizedBox(height: 28.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBADD1),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Salon Dashboard",
                        style: TextStyle(
                          color: Color(0xFFC93480),
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                        ),
                      ),
                      SizedBox(height: 25.0),
                      DashboardCard(title: 'View Appointments'),
                      DashboardCard(title: 'Manage Services'),
                      DashboardCard(title: 'Add Stylist'),
                      DashboardCard(title: 'Ratings and Feedbacks'),
                      DashboardCard(title: 'Manage Schedule'),
                      SizedBox(height: 25.0),
                      AppElevatedButton(
                        onPressed: () {},
                        child: Text('Logout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
