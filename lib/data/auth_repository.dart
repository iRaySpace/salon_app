import 'package:salon_app/domain/entities/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<UserCredential> signup(Customer customer, String password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: customer.email,
      password: password,
    );
    return credential;
  }
}
