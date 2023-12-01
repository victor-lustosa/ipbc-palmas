/*import 'package:flutter/material.dart';

import '../../../core_module.dart';

class FirestoreDatasource implements IDatasource {
  FirestoreDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;
  List<String> params = [];

  static Future init() async {
    await Future.wait<void>([
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    ]);
    // if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    // }
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  convert(List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) {
    var entities = docs
        .map((document) => {
              'id': document.id,
              ...document.data(),
            })
        .toList();
    return entities;
  }

  @override
  Future<dynamic> get(String url) async {
    params = url.split('/');
    var result = [];
    if (params.length > 2) {
      await _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .orderBy("createAt", descending: true)
          .limit(int.parse(params[3]))
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> value) {
        result = convert(value.docs);
      });
    } else {
      await _firestore
          .collection(params[0])
          .orderBy("createAt", descending: true)
          .limit(int.parse(params[1]))
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> value) {
        result = convert(value.docs);
      });
    }
    return result;
  }

  Future<String> verifyUpdateDatasource() async {
    String fireId = '';
    await _firestore
        .collection('settings')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      fireId = snapshot.docs.first.get('fireId');
    });
    return fireId;
  }

  @override
  Future<void> add(String url, data) async {
    params = url.split('/');
    if (params.length > 1) {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .add(data);
    } else {
      _firestore.collection(params[0]).add(data);
    }
  }

  @override
  Future<void> update(String url, data) async {
    params = url.split('/');
    if (params.length > 2) {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .doc(params[3])
          .update(data);
    } else {
      _firestore.collection(params[0]).doc(params[1]).update(data);
    }
  }

  @override
  Future<void> delete(String url) {
    throw UnimplementedError();
  }
}
*/