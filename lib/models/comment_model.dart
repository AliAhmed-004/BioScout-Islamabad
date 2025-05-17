import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 1)
class CommentModel extends HiveObject {
  @HiveField(0)
  final String id; // UUID or timestamp-based

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String commentText;

  @HiveField(3)
  final DateTime timestamp;

  CommentModel({
    required this.id,
    required this.userId,
    required this.commentText,
    required this.timestamp,
  });
}
