import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/rating.dart';

class RatingsRepository {
  Future<List<Rating>> getRatingsByUid(uid) async {
    final feedbackSnapshot = await FirebaseFirestore.instance
        .collection("feedback")
        .where('salonId', isEqualTo: uid)
        .get();
    final List<Rating> feedbacks = [];
    for (final doc in feedbackSnapshot.docs) {
      final data = doc.data();
      feedbacks.add(
        Rating(
          customerId: data['customerID'] ?? '',
          review: data['review'],
          salonId: data['salonId'],
          star: data['star'],
        ),
      );
    }
    return feedbacks;
  }
}
