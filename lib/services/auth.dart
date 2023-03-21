import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future signIn(String email, String password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e){
    print(e);
  }
}

Future signUp(String email, String password) async {
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e){
    print(e);
  }
}

Future<void>userSetup(String fullname, int nik, String phone, String username, String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  var users = FirebaseFirestore.instance;
  users.collection('users').doc(uid).set({
    'id': uid,
    'email': email,
    'fullname': fullname,
    'username': username,
    'nik': nik,
    'phone': phone,
    'role': "public"
  });
  return;
}
