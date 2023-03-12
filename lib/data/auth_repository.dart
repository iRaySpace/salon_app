import 'package:salon_app/domain/entities/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<UserCredential> signup(Customer customer, String password) async {
    // TODO: create a customer data
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: customer.email,
      password: password,
    );
    return credential;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }
}
