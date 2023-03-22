import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/salons/widgets/salon_card.dart';
import 'package:salon_app/app/widgets/app_bottom_navigation_bar.dart';
import 'package:salon_app/data/salon_repository.dart';

class SalonsView extends StatefulWidget {
  const SalonsView({super.key});

  @override
  State<SalonsView> createState() => _SalonsViewState();
}

class _SalonsViewState extends State<SalonsView> {
  List salonList = [];

  Future<void> getSalons() async {
    final salons = await SalonRepository().getSalons();
    setState(() {
      salonList = salons;
    });
  }

  @override
  void initState() {
    getSalons();
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
                child: const SafeArea(
                  child: Text(
                    'All Salons',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: salonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SalonCard(
                      title: salonList[index].salonName,
                      urlLogo: salonList[index].logoUrl,
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationItemsIndexed['salons'] as int,
      ),
    );
  }
}
