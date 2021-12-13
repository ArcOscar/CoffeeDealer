import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_dealer/models/coffee.dart';
import 'package:coffee_dealer/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // Collection Reference
  final CollectionReference coffeeCollection = Firestore.instance.collection('coffees');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  // Coffee list from snapshot
  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Coffee(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  // User data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  // Get Coffees Stream
  Stream<List<Coffee>> get coffees {
    return coffeeCollection.snapshots()
    .map(_coffeeListFromSnapshot);
  }

  // Get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}