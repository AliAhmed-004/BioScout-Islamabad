import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id; // Firestore doc ID
  final String? speciesName;
  final bool aiSuggested;
  final DateTime dateObserved;
  final String location;
  final String imageUrl;
  final String notes;
  final DateTime timestamp;
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
