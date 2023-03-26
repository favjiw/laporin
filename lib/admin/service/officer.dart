import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future officerAdd(String fullname, int nik, String phone, String username, String email, String password) async{
  try{
    final db = FirebaseFirestore.instance.collection('users');
    final ref = db.doc();
    ref.set({
      'id': ref.id,
      'email': email,
      'fullname': fullname,
      'username': username,
      'nik': nik,
      'phone': phone,
      'role': "officer",
      'password': password
    });
  } on FirebaseException catch (e){
    print(e);
  }
}

Future officerUpdate(String fullname, int nik, String phone, String username, String email, String password, String officerId) async{
  try{
    final ref = FirebaseFirestore.instance.collection('users').doc(officerId);
    ref.update({
      'email': email,
      'fullname': fullname,
      'username': username,
      'nik': nik,
      'phone': phone,
      'role': "officer",
      'password': password
    });
  } on FirebaseException catch (e){
    print(e);
  }
}

Future officerDelete(String docId) async {
  final db = FirebaseFirestore.instance;
  final ref = db.collection('users').doc(docId);
  ref.delete();
}