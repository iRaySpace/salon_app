class Appointment {
  const Appointment({
    required this.salonId,
    required this.date,
    required this.time,
    required this.email,
    required this.name,
    required this.progress,
    required this.service,
    required this.stylist,
    this.id,
  });

  final String salonId;
  final String date;
  final String time;
  final String email;
  final String name;
  final String progress;
  final String service;
  final String stylist;
  final String? id;

  static fromJson(data) {
    return Appointment(
      salonId: data['salonId'],
      date: data['date'],
      time: data['time'],
      email: data['email'] ?? "",
      name: data['name'],
      progress: data['progress'] ?? "",
      service: data['service'],
      stylist: data['stylist'] ?? "",
      id: data['id'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'date': date,
      'email': email,
      'name': name,
      'salonId': salonId,
      'service': service,
      'stylist': stylist,
      'time': time,
    };
  }
}
