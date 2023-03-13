import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/stylist.dart';

class StylistRepository {
  Future<Stylist> addStylist(Stylist stylist) async {
    await FirebaseFirestore.instance.collection("stylist").add({
      'createdAt': Timestamp.now(),
      ...stylist.toJson(),
    });
    return stylist;
  }

  Future<List<Stylist>> getStylists() async {
    final snapshot =
        await FirebaseFirestore.instance.collection("stylist").get();
    final List<Stylist> data = [];
    for (final docSnapshot in snapshot.docs) {
      final snapshotData = docSnapshot.data();
      data.add(Stylist.fromJson({...snapshotData, 'id': docSnapshot.id}));
    }
    return data;
  }
}
