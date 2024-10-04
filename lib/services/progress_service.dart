// services/progress_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_progress.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserProgress(String userId, UserProgress progress) async {
    await _firestore
        .collection('userProgress')
        .doc(userId)
        .set(progress.toMap());
  }

  Stream<UserProgress> getUserProgress(String userId) {
    return _firestore
        .collection('userProgress')
        .doc(userId)
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return UserProgress.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return UserProgress(); // Return a new UserProgress object if not found
      }
    });
  }
}
