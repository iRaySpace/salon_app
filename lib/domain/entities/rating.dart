class Rating {
  Rating({
    required this.customerId,
    required this.review,
    required this.salonId,
    required this.star,
  });

  final String customerId;
  final String review;
  final String salonId;
  final String star;

  Map<String, dynamic> toJSON() {
    return {
      'customerID': customerId,
      'review': review,
      'salonId': salonId,
      'star': star,
    };
  }
}
