import '../models/post_model.dart';

abstract class PostRepository {
  Future<void> addPost(PostModel post);
  Future<List<PostModel>> getAllPosts();
  Future<void> deletePost(String id);
  Future<void> clearAllPosts();
}
