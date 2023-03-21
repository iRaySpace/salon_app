import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/appointment.dart';

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

  Future<Appointment> addAppointment(Appointment appointment) async {
    await FirebaseFirestore.instance.collection("Appointment").add({
      'createdAt': Timestamp.now(),
      ...appointment.toJSON(),
    });
    return appointment;
  }
}
