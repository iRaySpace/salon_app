import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/salon.dart';

class SalonRepository {
  Future<List<dynamic>> getSalons() async {
    final salons = await FirebaseFirestore.instance.collection("salon").get();
    final data = [];
    salons.docs.forEach((salon) {
      final salonData = salon.data();
      final laaganTrainee = Salon.fromJson(salonData);
      data.add(laaganTrainee);
    });
    return data;
  }
}
