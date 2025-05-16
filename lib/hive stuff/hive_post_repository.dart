import 'post_repository.dart';
import 'post_local_data_source.dart';
import '../models/post_model.dart';

class HivePostRepository implements PostRepository {
  final PostLocalDataSource localDataSource;

  HivePostRepository({required this.localDataSource});

  @override
  Future<void> addPost(PostModel post) => localDataSource.savePost(post);

  @override
  Future<List<PostModel>> getAllPosts() => localDataSource.getAllPosts();

  @override
  Future<void> deletePost(String id) => localDataSource.deletePost(id);

  @override
  Future<void> clearAllPosts() => localDataSource.clearAllPosts();
}
