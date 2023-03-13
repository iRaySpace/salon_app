class Customer {
  Customer({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.type,
    this.uid,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String type;

  final String? uid;

  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'type': type,
    };
  }
}
