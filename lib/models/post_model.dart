import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'post_model.g.dart';

@HiveType(typeId: 0)
class PostModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? speciesName;

  @HiveField(2)
  final bool aiSuggested;

  @HiveField(3)
  final DateTime dateObserved;

  @HiveField(4)
  final String location;

  @HiveField(5)
  final String imageUrl;

  @HiveField(6)
  final String notes;

  @HiveField(7)
  final DateTime timestamp;

  @HiveField(8)
  final String userId;

  PostModel({
    required this.id,
    this.speciesName,
    required this.aiSuggested,
    required this.dateObserved,
    required this.location,
    required this.imageUrl,
    required this.notes,
    required this.timestamp,
    required this.userId,
  });

  factory PostModel.fromMap(Map<String, dynamic> data, String docId) {
    return PostModel(
      id: docId,
      speciesName: data['speciesName'],
      aiSuggested: data['aiSuggested'] ?? false,
      dateObserved: (data['dateObserved'] as Timestamp).toDate(),
      location: data['location'],
      imageUrl: data['imageUrl'],
      notes: data['notes'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      userId: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'speciesName': speciesName,
      'aiSuggested': aiSuggested,
      'dateObserved': dateObserved,
      'location': location,
      'imageUrl': imageUrl,
      'notes': notes,
      'timestamp': timestamp,
      'userId': userId,
    };
  }

  factory PostModel.mock({
    required String id,
    String? speciesName,
    bool aiSuggested = false,
    DateTime? dateObserved,
    String location = "Margalla Hills",
    required String imageUrl,
    String notes = "No additional notes.",
    required String userId, // ✅ add this
  }) {
    return PostModel(
      id: id,
      speciesName: speciesName,
      aiSuggested: aiSuggested,
      dateObserved: dateObserved ?? DateTime.now(),
      location: location,
      imageUrl: imageUrl,
      notes: notes,
      timestamp: DateTime.now(),
      userId: userId, // ✅ set here
    );
  }
}
