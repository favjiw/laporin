import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future onCreateOfficer(String uid, Timestamp timestamp) async {
  try{
    final db = FirebaseFirestore.instance.collection('user_log');
    final ref = db.doc();
    ref.set({
      'id': ref.id,
      'action_by': uid,
      'action': "Create",
      'action_time': timestamp
    });
  }catch (e){
    print('error onCreate Officer : $e');
  }
}


Future onUpdateOfficer(String uid, Timestamp timestamp) async {
  try{
    final db = FirebaseFirestore.instance.collection('user_log');
    final ref = db.doc();
    ref.set({
      'id': ref.id,
      'action_by': uid,
      'action': "Update",
      'action_time': timestamp
    });
  }catch (e){
    print('error onUpdate Officer : $e');
  }
}

Future onDeleteOfficer(String uid, Timestamp timestamp) async {
  try{
    final db = FirebaseFirestore.instance.collection('user_log');
    final ref = db.doc();
    ref.set({
      'id': ref.id,
      'action_by': uid,
      'action': "Delete",
      'action_time': timestamp
    });
  }catch (e){
    print('error onDelete Officer : $e');
  }
}