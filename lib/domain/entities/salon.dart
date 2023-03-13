class Salon {
  Salon({
    required this.salonName,
    required this.salonLocation,
    required this.email,
    required this.contactNumber,
    required this.businessRegistration,
    required this.logoUrl,
    required this.uid,
    required this.id,
  });

  final String salonName;
  final String salonLocation;
  final String email;
  final int contactNumber;
  final String businessRegistration;
  final String logoUrl;
  final String? uid;
  final String? id;

  static fromJson(data) {
    return Salon(
      salonName: data['salonName'],
      salonLocation: data['salonLocation'],
      email: data['email'],
      contactNumber: data['contactNumber'],
      businessRegistration: data['businessRegistration'],
      logoUrl: data['logoUrl'],
      uid: data['uid'],
      id: data['id'],
    );
  }
}
