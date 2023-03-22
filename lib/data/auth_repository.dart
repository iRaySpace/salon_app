import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/domain/entities/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  static Customer? customer; // for auth purposes

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

  Future<Customer> signIn(String email, String password) async {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    final uid = credential.user!.uid;
    final customerSnapshot = (await FirebaseFirestore.instance
            .collection("customer")
            .where("uid", isEqualTo: uid)
            .get())
        .docs
        .first;
    final customerData = customerSnapshot.data();
    final customer = Customer(
      uid: customerData['uid'],
      email: customerData['email'],
      firstName: customerData['firstName'],
      lastName: customerData['lastName'],
      type: customerData['type'],
      gender: '',
    );
    AuthRepository.customer = customer;
    return customer;
  }

  Future<void> reload() async {
    final user = await FirebaseAuth.instance.authStateChanges().first;
    if (user != null) {
      final customerSnapshot = (await FirebaseFirestore.instance
              .collection("customer")
              .where("uid", isEqualTo: user.uid)
              .get())
          .docs
          .first;
      final customerData = customerSnapshot.data();
      final customer = Customer(
        uid: customerData['uid'],
        email: customerData['email'],
        firstName: customerData['firstName'],
        lastName: customerData['lastName'],
        type: customerData['type'],
        gender: '',
      );
      AuthRepository.customer = customer;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    AuthRepository.customer = null;
  }
}
