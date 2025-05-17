import 'package:bioscout/rag%20helper/rag_helper.dart' show RAGChatBotHelper;
import 'package:bioscout/secrets.dart';
import 'package:flutter/material.dart';
import '../hive stuff/post_repository.dart';
import '../models/post_model.dart'; // adjust path as needed

class PostProvider with ChangeNotifier {
  final PostRepository repository;
  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  PostProvider({required this.repository});

  void loadMockPosts() {
    _posts.clear();
    _posts.addAll([
      PostModel.mock(
        id: '1',
        imageUrl: 'assets/icons/cactus.jpg',
        speciesName: 'Cactus',
        aiSuggested: true,
        notes: 'Seen near Trail 3',
        userId: 'u123',
      ),
      PostModel.mock(
        id: '2',
        imageUrl: 'assets/icons/orchid.jpg',
        notes: 'Found something unique!',
        userId: 'u123',
      ),
    ]);
    notifyListeners();
  }

  Future<void> loadPosts() async {
    _posts.clear();
    _posts.addAll(await repository.getAllPosts());
    notifyListeners();
  }

  Future<void> addPost(PostModel post) async {
    await repository.addPost(post);
    _posts.add(post);

    final ragHelper = RAGChatBotHelper(geminiApi);
    await ragHelper.appendPostToDataset(post);

    notifyListeners();
  }

  void removePost(String id) {
    _posts.removeWhere((post) => post.id == id);
    notifyListeners();
  }

  void clearAll() {
    _posts.clear();
    notifyListeners();
  }
}
