import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/event.dart';
import '../model/user.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUserCollections() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
      fromFirestore: (snapshot, options) =>
          MyUser.fromFireStore(snapshot.data()!),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  static CollectionReference<Event> getEventsCollections() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
      fromFirestore: (snapshot, options) =>
          Event.fromFireStore(snapshot.data()!),
      toFirestore: (event, options) => event.toFireStore(),
    );
  }


  static Future<void> addUserInFireStore(MyUser myUser) {
    CollectionReference<MyUser> collectionRef = getUserCollections();
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
    return docRef.set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> querySnapshot = await getUserCollections()
        .doc(uId)
        .get();
    return querySnapshot.data();
  }
  static Future<void> addEventInFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventsCollections();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.eventId = docRef.id;

    return docRef.set(event);
  }
  static Future<void>deleteEventFireSore(String id){
    return getEventsCollections().doc(id).delete();
  }
  static Future<void>updateEventFirestore(Event event){
    return getEventsCollections().doc(event.eventId).update(event.toFireStore());
  }
  static Stream<List<Event>> getAllEvents(String uId) {
    Stream<QuerySnapshot<Event>> stream = getEventsCollections()
        .where('uId', isEqualTo: uId)
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  static Stream<List<Event>> getAllFavouriteEvents(String uId) {
    return getEventsCollections()
        .where('is_favourite', isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) => doc.data()).toList());
  }

  static Stream<List<Event>> getFilterEvents({required int selectedIndex,String? uId}) {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventsCollections()
        .where('uId', isEqualTo: uId)
        .where('event_category_index', isEqualTo: selectedIndex)
        .orderBy('event_date')
        .snapshots();
    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> updateIsFavourite(Event event) {
    return getEventsCollections().doc(event.eventId).update({
      'is_favourite': !event.isFavourite,
    });
  }




}
