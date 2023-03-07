import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                              labelText: 'First Name',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Last Name',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Password',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Confirm Password',
                            ),
                          ),
                          SizedBox(height: 15.0),
                          AppElevatedButton(
                            onPressed: () {},
                            child: Text('Create an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  const Text(
                    'Already have an account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Sign in'),
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
