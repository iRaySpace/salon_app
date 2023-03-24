import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/appointments/appointments_view.dart';
import 'package:salon_app/app/pages/logout/logout_view.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/app/pages/ratings/ratings_view.dart';
import 'package:salon_app/app/pages/salon_dashboard/widgets/dashboard_card.dart';
import 'package:salon_app/app/pages/schedule/schedule_view.dart';
import 'package:salon_app/app/pages/services/services_view.dart';
import 'package:salon_app/app/pages/stylists/stylists_view.dart';
import 'package:salon_app/app/widgets/dialog.dart';
import 'package:salon_app/data/auth_repository.dart';
import 'package:salon_app/data/customer_repository.dart';
import 'package:salon_app/data/salon_repository.dart';
import 'package:salon_app/data/utils.dart';

class SalonDashboardView extends StatefulWidget {
  const SalonDashboardView({super.key});

  @override
  State<SalonDashboardView> createState() => _SalonDashboardViewState();
}

class _SalonDashboardViewState extends State<SalonDashboardView> {
  bool _isLoading = true;

  void loadSalon() async {
    final customer = AuthRepository.customer;
    final salon = await SalonRepository().getSalonByUid(customer!.uid);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    loadSalon();
    super.initState();
  }

  void handleRatings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RatingsView(),
      ),
    );
  }

  void handleStylist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const StylistsView(),
      ),
    );
  }

  void handleServices() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServicesView(),
      ),
    );
  }

  void handleSchedule() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ScheduleView(),
      ),
    );
  }

  void handleAppointments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AppointmentsView(),
      ),
    );
  }

  void handleLogout() async {
    showLogoutDialog(context, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogoutView(),
        ),
      );
    });
  }

  void handlePublish() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 15.0),
                Text('Publishing Salon...'),
              ],
            ),
          ),
        );
      },
    );

    try {
      final salonId = SalonRepository.salon!.id;
      final salonReady = await isSalonReady(salonId);
      Navigator.of(context).pop();
      if (salonReady) {
      } else {
        showOkDialog(
          context: context,
          titleText: 'Unable to publish',
          contentText:
              'Please setup your services, stylist, and schedules first!',
        );
      }
    } on Exception catch (e, s) {
      Navigator.of(context).pop();
    }
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
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(25.0),
                  padding: const EdgeInsets.all(25.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBADD1),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: _isLoading
                      ? Column(
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(height: 10.0),
                            Text(
                              'Loading',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Text(
                              "Salon Dashboard",
                              style: TextStyle(
                                color: Color(0xFFC93480),
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0,
                              ),
                            ),
                            const SizedBox(height: 25.0),
                            DashboardCard(
                              title: 'View Appointments',
                              onTap: handleAppointments,
                            ),
                            DashboardCard(
                              title: 'Manage Services',
                              onTap: handleServices,
                            ),
                            DashboardCard(
                              title: 'Manage Stylist',
                              onTap: handleStylist,
                            ),
                            DashboardCard(
                              title: 'Ratings and Feedbacks',
                              onTap: handleRatings,
                            ),
                            DashboardCard(
                              title: 'Manage Schedule',
                              onTap: handleSchedule,
                            ),
                            const SizedBox(height: 25.0),
                            AppElevatedButton(
                              onPressed: handlePublish,
                              child: const Text("Publish"),
                            ),
                            const SizedBox(height: 15.0),
                            AppElevatedButton(
                              onPressed: handleLogout,
                              child: const Text('Logout'),
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
