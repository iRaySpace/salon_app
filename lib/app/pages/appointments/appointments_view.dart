import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_app/app/pages/salon_dashboard/salon_dashboard_view.dart';
import 'package:salon_app/data/appointment_repository.dart';
import 'package:salon_app/data/salon_repository.dart';
import 'package:salon_app/data/schedule_repository.dart';
import 'package:salon_app/domain/entities/appointment.dart';
import 'package:salon_app/domain/entities/schedule.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  List<Appointment> _appointments = [];

  void loadAppointments() async {
    final appointments = await AppointmentRepository()
        .getAppointmentsByUid(SalonRepository.salon!.id);
    setState(() {
      _appointments = appointments;
    });
  }

  @override
  void initState() {
    loadAppointments();
    super.initState();
  }

  void handleBack() {
    Navigator.of(context).pop();
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
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: handleBack,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFFC93480),
                              size: 28.0,
                            ),
                          ),
                          const Text(
                            'Appointments',
                            style: TextStyle(
                              color: Color(0xFFC93480),
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  ..._appointments
                      .map((appointment) => AppointmentCard(data: appointment)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.data,
  });

  final Appointment data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 25.0,
          top: 15.0,
          right: 25.0,
          bottom: 15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.name,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Service',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  data.service,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stylist',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  data.stylist,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Date',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  data.date,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Time',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  data.time,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
