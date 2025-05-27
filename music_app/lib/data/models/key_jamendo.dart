import 'package:cloud_firestore/cloud_firestore.dart';

class KeyJamendo {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static Future<String?> getKey() async {
    try {
      final doc = await _firebaseFirestore.collection('key').doc('key').get();
      if (doc.exists) {
        return doc.data()?['key'] as String?;
      }
    } catch (e) {}
    return null;
  }
}
