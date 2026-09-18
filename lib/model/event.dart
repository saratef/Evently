import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';
  String eventId;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  int eventCategoryIndex;
  bool isFavourite;
  String uId;
  Event({
    this.eventId = '',
    required this.eventName,
    required this.eventDate,
    required this.eventDescription,
    required this.eventImage,
    required this.eventTitle,
    required this.eventCategoryIndex,
    this.isFavourite = false,
    this.uId = '',
  });

  Event.fromFireStore(Map<String, dynamic> data)
      : this(
    eventId: data['event_id'] ?? '',
    eventName: data['event_name'] ?? '',
    eventImage: data['event_image'] ?? '',
    eventTitle: data['event_title'] ?? '',
    eventDescription: data['event_description'] ?? '',
    eventDate: data['event_date'] != null
        ? (data['event_date'] as Timestamp).toDate()
        : DateTime.now(),
    eventCategoryIndex: data['event_category_index'] ?? 0,
    isFavourite: data['is_favourite'] ?? false,
    uId: data['uId'] ?? '',
  );

  Map<String, dynamic> toFireStore() {
    return {
      'event_id': eventId,
      'event_name': eventName,
      'event_date': Timestamp.fromDate(eventDate),
      'event_description': eventDescription,
      'event_image': eventImage,
      'event_title': eventTitle,
      'is_favourite': isFavourite,
      'event_category_index': eventCategoryIndex,
      'uId': uId,
    };
  }
}