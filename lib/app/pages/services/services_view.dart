import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/services/services_add_view.dart';
import 'package:salon_app/app/pages/stylists/stylists_add_view.dart';
import 'package:salon_app/data/salon_repository.dart';
import 'package:salon_app/data/service_repository.dart';
import 'package:salon_app/data/stylist_repository.dart';
import 'package:salon_app/domain/entities/service.dart';
import 'package:salon_app/domain/entities/stylist.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _StylistsViewState();
}

class _StylistsViewState extends State<ServicesView> {
  List<Service> _services = [];

  void loadStylists() async {
    final services =
        await ServiceRepository().getServicesByUid(SalonRepository.salon!.id);
    setState(() {
      _services = services;
    });
  }

  @override
  void initState() {
    loadStylists();
    super.initState();
  }

  void handleBack() {
    Navigator.of(context).pop();
  }

  void handleAdd() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServicesAddView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFD9ED),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: handleBack,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFFC93480),
                              size: 28.0,
                            ),
                          ),
                          const Text(
                            'Services',
                            style: TextStyle(
                              color: Color(0xFFC93480),
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: handleAdd,
                        icon: const Icon(
                          Icons.add,
                          color: Color(0xFFC93480),
                          size: 28.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  ..._services
                      .map(
                        (service) => ServiceColumn(
                          service: service.category,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceColumn extends StatelessWidget {
  const ServiceColumn({
    super.key,
    required this.service,
  });
  final String service;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 15.0),
        Text(service, textAlign: TextAlign.left),
        const SizedBox(height: 15.0),
        const Divider(),
      ],
    );
  }
}
