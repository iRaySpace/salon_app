import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/app/pages/salon_dashboard/salon_dashboard_view.dart';
import 'package:salon_app/app/pages/salon_signup/salon_signup_view.dart';
import 'package:salon_app/app/pages/signin/signin_view.dart';
import 'package:salon_app/app/pages/signup/signup_view.dart';
import 'package:salon_app/app/widgets/app_bottom_navigation_bar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  void handleSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupView(),
      ),
    );
  }

  void handleLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SigninView(),
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
              padding: const EdgeInsets.all(25.0),
              child: NewProfileColumn(
                handleLogin: handleLogin,
                handleSignup: handleSignup,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationItemsIndexed['profile'] as int,
      ),
    );
  }
}

class NewProfileColumn extends StatelessWidget {
  const NewProfileColumn({
    super.key,
    required this.handleLogin,
    required this.handleSignup,
  });

  final Function() handleLogin;
  final Function() handleSignup;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 56.0),
        AppElevatedButton(
          onPressed: handleLogin,
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        AppElevatedButton(
          onPressed: handleSignup,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
