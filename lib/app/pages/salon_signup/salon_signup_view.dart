import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';

class SalonSignupView extends StatefulWidget {
  const SalonSignupView({super.key});

  @override
  State<SalonSignupView> createState() => _SalonSignupViewState();
}

class _SalonSignupViewState extends State<SalonSignupView> {
  void handleSignup() {}

  void handleUpload() {}

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
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 56.0),
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
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Salon Name',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Address',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Mobile Number',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Business Registration',
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          AppElevatedButton(
                            onPressed: handleUpload,
                            child: const Text('Upload Logo'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: false,
                        onChanged: (e) {},
                      ),
                      const Text('I agree in all terms and conditions'),
                    ],
                  ),
                  AppElevatedButton(
                    onPressed: handleSignup,
                    child: const Text('Start your journey'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
