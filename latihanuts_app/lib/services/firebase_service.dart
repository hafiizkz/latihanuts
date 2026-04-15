import 'package:firebase_database/firebase_database.dart';
import '../models/narapidana_model.dart';

class FirebaseService {
  final DatabaseReference _db =
      FirebaseDatabase.instance.ref("narapidana");

  Future<void> tambahData(Narapidana data) async {
    await _db.push().set(data.toMap());
  }

  Stream<List<Narapidana>> getData() {
    return _db.onValue.map((event) {
      final data = event.snapshot.value as Map?;
      if (data == null) return [];

      return data.entries.map((e) {
        return Narapidana.fromMap(
            e.key, Map<String, dynamic>.from(e.value));
      }).toList();
    });
  }
}