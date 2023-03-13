import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<UserCredential> signup(Customer customer, String password) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: customer.email,
      password: password,
    );
    await FirebaseFirestore.instance.collection("customer").add({
      'createdAt': Timestamp.now(),
      'uid': credential.user!.uid,
      ...customer.toJSON(),
    });
    return credential;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }
}
