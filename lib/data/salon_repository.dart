import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/salon.dart';

class SalonRepository {
  static Salon? salon;

  Future<List<dynamic>> getSalons() async {
    final salons = await FirebaseFirestore.instance.collection("salon").get();
    final data = [];
    salons.docs.forEach((salon) {
      final salonData = salon.data();
      final laaganTrainee = Salon.fromJson({...salonData, 'id': salon.id});
      data.add(laaganTrainee);
    });
    return data;
  }

  Future<Salon> getSalonByUid(uid) async {
    final salonSnapshot = await FirebaseFirestore.instance
        .collection("salon")
        .where("uid", isEqualTo: uid)
        .get();
    final salonDoc = salonSnapshot.docs.first;
    final salonData = salonDoc.data();
    final salon = Salon.fromJson({...salonData, 'id': salonDoc.id});
    SalonRepository.salon = salon;
    return salon;
  }
}
