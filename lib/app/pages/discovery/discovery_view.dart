import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/discovery/widgets/discovery_card.dart';
import 'package:salon_app/app/pages/discovery/widgets/top_card.dart';
import 'package:salon_app/app/widgets/app_bottom_navigation_bar.dart';
import 'package:salon_app/data/salon_repository.dart';

class DiscoveryView extends StatefulWidget {
  const DiscoveryView({super.key});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  List salonList =[];

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 56.0),
                Container(
                  height: 128.0,
                  child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: salonList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DiscoveryCard(urlLogo:salonList[index].logoUrl);
                    })),
                const SizedBox(height: 28.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBADD1),
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Top Rated Salon",
                        style: TextStyle(
                          color: Color(0xFFC93480),
                          fontWeight: FontWeight.bold,
                          fontSize: 21.0,
                        ),
                      ),
                  SizedBox(height: 20,),
                   GridView.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                      crossAxisCount: 2,
                      children: List.generate(salonList.length, (index) {
                        return TopCard(urlLogo:salonList[index].logoUrl);
                      }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationItemsIndexed['discovery'] as int,
      ),
    );
  }
}
