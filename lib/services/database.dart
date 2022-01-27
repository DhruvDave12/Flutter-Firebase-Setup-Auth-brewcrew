import 'package:brew_crew/models/brews.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // We are gonna take UID from the user
  final String? uid;
  DatabaseService({this.uid});
  // collection reference
  // Below line creates a collection named brews in our database where we will be able to store the data of brews

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    // if document of user doesnt exist in this particular collection then it will
    // create a document with this uid.
    return await brewCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  // Now we will be setting up a stream which will notify us when there will be a change in document.

  // Brew list from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc['name'] ?? '',
          sugars: doc['sugars'] ?? '0',
          strength: doc['strength'] ?? 0);
    }).toList();
  }

  // get brews streams
  Stream<List<Brew>> get brews {
    // from here in the stream we get snapshots of brew changes and then we can convert it into our defined datatype Brew and then
    // we return List of Brew as we do always.

    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // User Data from snapshots
  UserData _userDatafromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot['name'],
        sugars: snapshot['sugars'],
        strength: snapshot['strength']);
  }

  // get user doc stream
  Stream<UserData> get userData {

    // mapping snapshot to user data and returning stream of user data
    return brewCollection.doc(uid).snapshots().map(_userDatafromSnapshot);
  }
}
