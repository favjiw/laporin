import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


Future respondAdd(String desc, String complaintId, String userId) async {
  try{
    Timestamp now = Timestamp.now();
    DateTime dateTime = now.toDate();
    // String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    final timestamp = Timestamp.fromDate(dateTime);
    print(timestamp);
    final db = FirebaseFirestore.instance.collection('complaints').doc(complaintId).collection('respond');
    final ref = db.doc();
    ref.set({
      'id': ref.id,
      'date': timestamp,
      'desc': desc,
      'complaintId': complaintId,
      'operatorId': userId
    });
  } on FirebaseException catch (e){
    print(e);
  }
}