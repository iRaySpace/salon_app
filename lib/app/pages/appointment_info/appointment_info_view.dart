import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salon_app/app/pages/appointment_info/appointment_info_successful_view.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/data/appointment_repository.dart';
import 'package:salon_app/data/service_repository.dart';
import 'package:salon_app/data/stylist_repository.dart';
import 'package:salon_app/domain/entities/appointment.dart';
import 'package:salon_app/domain/entities/salon.dart';
import 'package:salon_app/domain/entities/service.dart';
import 'package:salon_app/domain/entities/stylist.dart';

class AppointmentInfoView extends StatefulWidget {
  const AppointmentInfoView({super.key, required this.salon});
  final Salon salon;
  @override
  State<AppointmentInfoView> createState() => _AppointmentInfoViewState();
}

class _AppointmentInfoViewState extends State<AppointmentInfoView> {
  List<Service> _services = [];
  List<Stylist> _stylists = [];

  final _nameController = TextEditingController(text: 'Test');
  final _emailController = TextEditingController(text: 'test@test.com');
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _data = {};

  void loadData() async {
    final services =
        await ServiceRepository().getServicesByUid(widget.salon.id);
    final stylists =
        await StylistRepository().getStylistsByUid(widget.salon.id);
    setState(() {
      _services = services;
      _stylists = stylists;
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void handleDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2099),
    );
    if (selectedDate != null) {
      _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
  }

  void handleTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      final now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      _timeController.text = DateFormat.Hm().format(date);
    }
  }

  void handleAdd() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 15.0),
                  Text('Creating an appointment'),
                ],
              ),
            ),
          );
        },
      );

      final appointment = Appointment(
        date: _data['date'],
        time: _data['time'],
        name: _data['name'],
        email: 'test@test.com',
        service: _data['service'],
        stylist: _data['stylist'],
        salonId: 'YS6Nd8hZtB5QlPWtHE0D',
        progress: '',
      );

      try {
        await AppointmentRepository().addAppointment(appointment);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AppointmentInfoSuccessfulView(),
          ),
        );
      } catch (e) {
        Navigator.of(context).pop();
      }
    }
  }

  void handleBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFD9ED),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFC93480),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: handleBack,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28.0,
                        ),
                      ),
                      const Text(
                        'Appointment Info',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 56.0),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              TextFormField(
                                enabled: false,
                                controller: _nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input name';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _data['name'] = newValue!,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextFormField(
                                enabled: false,
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input email';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _data['email'] = newValue!,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              DropdownButtonFormField(
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input service';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _data['service'] = newValue!,
                                decoration: const InputDecoration(
                                  labelText: 'Services',
                                ),
                                onChanged: (value) {},
                                items: _services
                                    .map((service) => service.category)
                                    .map((service) {
                                  return DropdownMenuItem(
                                    value: service,
                                    child: Text(
                                      service,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 5.0),
                              DropdownButtonFormField(
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input stylist';
                                  }
                                  return null;
                                },
                                onSaved: (newValue) =>
                                    _data['stylist'] = newValue!,
                                decoration: const InputDecoration(
                                  labelText: 'Stylist',
                                ),
                                onChanged: (value) {},
                                items: _stylists
                                    .map((stylist) => stylist.stylist)
                                    .map((stylist) {
                                  return DropdownMenuItem(
                                    value: stylist,
                                    child: Text(
                                      stylist,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                              ),
                              TextFormField(
                                controller: _dateController,
                                onSaved: (newValue) =>
                                    _data['date'] = newValue!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input date';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Date',
                                ),
                                onTap: handleDate,
                              ),
                              TextFormField(
                                controller: _timeController,
                                onSaved: (newValue) =>
                                    _data['time'] = newValue!,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input time';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.none,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Time',
                                ),
                                onTap: handleTime,
                              ),
                              const SizedBox(height: 10.0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      AppElevatedButton(
                        onPressed: handleAdd,
                        child: const Text('Add Appointment'),
                      ),
                      const SizedBox(height: 35.0),
                      const Text(
                        'Other Salons',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
