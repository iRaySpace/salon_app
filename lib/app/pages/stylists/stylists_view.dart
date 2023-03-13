import 'package:flutter/material.dart';
import 'package:salon_app/data/salon_repository.dart';
import 'package:salon_app/data/stylist_repository.dart';
import 'package:salon_app/domain/entities/stylist.dart';

class StylistsView extends StatefulWidget {
  const StylistsView({super.key});

  @override
  State<StylistsView> createState() => _StylistsViewState();
}

class _StylistsViewState extends State<StylistsView> {
  List<Stylist> _stylists = [];

  void loadStylists() async {
    final stylists =
        await StylistRepository().getStylistsByUid(SalonRepository.salon!.id);
    setState(() {
      _stylists = stylists;
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
                        'Stylists',
                        style: TextStyle(
                          color: Color(0xFFC93480),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  ..._stylists
                      .map(
                        (stylist) => StylistColumn(
                          stylist: stylist.stylist,
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

class StylistColumn extends StatelessWidget {
  const StylistColumn({
    super.key,
    required this.stylist,
  });
  final String stylist;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 15.0),
        Text(stylist, textAlign: TextAlign.left),
        const SizedBox(height: 15.0),
        const Divider(),
      ],
    );
  }
}
