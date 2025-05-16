import 'package:hive/hive.dart';
import '../models/post_model.dart';

class PostLocalDataSource {
  static const String boxName = 'posts_box';

  Future<void> savePost(PostModel post) async {
    final box = await Hive.openBox<PostModel>(boxName);
    await box.put(post.id, post);
  }

  Future<List<PostModel>> getAllPosts() async {
    final box = await Hive.openBox<PostModel>(boxName);
    return box.values.toList();
  }

  Future<void> deletePost(String id) async {
    final box = await Hive.openBox<PostModel>(boxName);
    await box.delete(id);
  }

  Future<void> clearAllPosts() async {
    final box = await Hive.openBox<PostModel>(boxName);
    await box.clear();
  }
}
