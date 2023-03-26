import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/appointment.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/env.dart';

class AppointmentRepository {
  Future<List<Appointment>> getAppointmentsByUid(uid) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Appointment")
        .where('salonId', isEqualTo: uid)
        .get();
    final List<Appointment> data = [];
    for (final doc in snapshot.docs) {
      final docData = doc.data();
      data.add(Appointment.fromJson({...docData, 'id': doc.id}));
    }
    return data;
  }

  Future<List<Appointment>> getAppointmentsByEmail(email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("Appointment")
        .where('email', isEqualTo: email)
        .get();
    final List<Appointment> data = [];
    for (final doc in snapshot.docs) {
      final docData = doc.data();
      data.add(Appointment.fromJson({...docData, 'id': doc.id}));
    }
    return data;
  }

  Future<Appointment> addAppointment(Appointment appointment) async {
    await FirebaseFirestore.instance.collection("Appointment").add({
      'createdAt': Timestamp.now(),
      ...appointment.toJSON(),
    });
    return appointment;
  }

  Future<void> setAppointmentAccept(Appointment appointment) async {
    await FirebaseFirestore.instance
        .collection("Appointment")
        .doc(appointment.id)
        .set({'progress': 'accepted'}, SetOptions(merge: true));
  }

  Future<void> setAppointmentReject(Appointment appointment) async {
    await FirebaseFirestore.instance
        .collection("Appointment")
        .doc(appointment.id)
        .set({'progress': 'rejected'}, SetOptions(merge: true));
  }

  Future<void> sendEmailAccept(Appointment appointment, salonName) async {
    final emailBody = {
      "personalizations": [
        {
          "to": [
            {"email": appointment.email, "name": appointment.name}
          ],
          "dynamic_template_data": {
            "salon": salonName,
            "name": appointment.name,
            "service": appointment.service,
            "stylist": appointment.stylist,
            "date_time": '${appointment.date} - ${appointment.time}',
          },
        },
      ],
      "template_id": "d-6b739d6092a649a89e8600390016276f",
      "from": {"email": "salonbeau08@gmail.com", "name": "Salon Beau"},
      "reply_to": {"email": "salonbeau08@gmail.com", "name": "Salon Beau"},
    };

    final headers = {
      'Authorization': 'Bearer $sendgridApiKey',
      'Content-Type': 'application/json',
    };

    await http.post(
      Uri.parse('https://api.sendgrid.com/v3/mail/send'),
      headers: headers,
      body: jsonEncode(emailBody),
    );
  }

  Future<void> sendEmailReject(Appointment appointment, salonName) async {
    final emailBody = {
      "personalizations": [
        {
          "to": [
            {"email": appointment.email, "name": appointment.name}
          ],
          "dynamic_template_data": {
            "salon": salonName,
            "name": appointment.name,
            "service": appointment.service,
            "stylist": appointment.stylist,
            "date_time": '${appointment.date} - ${appointment.time}',
          },
        },
      ],
      "template_id": "d-29163b2 47351434cb6d95c11ea6aadd1",
      "from": {"email": "salonbeau08@gmail.com", "name": "Salon Beau"},
      "reply_to": {"email": "salonbeau08@gmail.com", "name": "Salon Beau"},
    };

    final headers = {
      'Authorization': 'Bearer $sendgridApiKey',
      'Content-Type': 'application/json',
    };

    await http.post(
      Uri.parse('https://api.sendgrid.com/v3/mail/send'),
      headers: headers,
      body: jsonEncode(emailBody),
    );
  }
}
