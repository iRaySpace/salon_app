import 'package:flutter/material.dart';
import 'package:salon_app/app/pages/appointment_schedules/appointment_schedules_view.dart';
import 'package:salon_app/app/pages/logout/logout_view.dart';
import 'package:salon_app/app/pages/profile/widgets/app_elevated_button.dart';
import 'package:salon_app/app/pages/salon_dashboard/salon_dashboard_view.dart';
import 'package:salon_app/app/pages/salon_signup/salon_signup_view.dart';
import 'package:salon_app/app/pages/signin/signin_view.dart';
import 'package:salon_app/app/pages/signup/signup_view.dart';
import 'package:salon_app/app/widgets/app_bottom_navigation_bar.dart';
import 'package:salon_app/app/widgets/dialog.dart';
import 'package:salon_app/data/auth_repository.dart';
import 'package:salon_app/domain/entities/customer.dart';
import 'package:salon_app/domain/entities/salon.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Customer? customer = AuthRepository.customer;

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

  void handleLogout() async {
    await AuthRepository().logout();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogoutView(),
      ),
    );
  }

  void handleSalon() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SalonDashboardView(),
      ),
    );
  }

  void handleAppointments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AppointmentSchedulesView(),
      ),
    );
  }

  void handleSalonSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SalonSignupView(),
      ),
    );
  }

  Widget getColumn() {
    if (customer == null) {
      return NewProfileColumn(
        handleLogin: handleLogin,
        handleSignup: handleSignup,
      );
    }
    if (customer?.type == Customer.salonType) {
      return SalonProfileColumn(
        onLogout: () {
          showLogoutDialog(context, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LogoutView(),
              ),
            );
          });
        },
        onSalon: handleSalon,
      );
    }
    if (customer?.type == Customer.customerType) {
      return CustomerProfileColumn(
        onSalonSignup: handleSalonSignup,
        onAppointments: handleAppointments,
        onLogout: handleLogout,
      );
    }
    return Container();
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
              child: getColumn(),
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
        const Text(
          "BEAUtify with SalonBeau!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            color: Color(0xFFC93480),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Get started by creating your account",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 35.0),
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

class SalonProfileColumn extends StatelessWidget {
  const SalonProfileColumn({
    super.key,
    required this.onSalon,
    required this.onLogout,
  });

  final Function() onSalon;
  final Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 56.0),
        const Text(
          'Welcome, ka-SalonBeau!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            color: Color(0xFFC93480),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Check how your Salon is doing!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 35.0),
        AppElevatedButton(
          onPressed: onSalon,
          child: const Text(
            "Your Salon",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        AppElevatedButton(
          onPressed: onLogout,
          child: const Text(
            'Logout',
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

class CustomerProfileColumn extends StatelessWidget {
  const CustomerProfileColumn({
    super.key,
    required this.onSalonSignup,
    required this.onAppointments,
    required this.onLogout,
  });

  final Function() onSalonSignup;
  final Function() onAppointments;
  final Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 56.0),
        const Text(
          "Welcome to SalonBeau!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28.0,
            color: Color(0xFFC93480),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          "Get started now",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 35.0),
        AppElevatedButton(
          onPressed: onSalonSignup,
          child: const Text(
            "Start your Salon's Journey",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        AppElevatedButton(
          onPressed: onAppointments,
          child: const Text(
            "My Appointments",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15.0),
        AppElevatedButton(
          onPressed: onLogout,
          child: const Text(
            'Logout',
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
