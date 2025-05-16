import 'package:flutter/material.dart';
import '../models/post_model.dart'; // adjust path as needed

class PostProvider with ChangeNotifier {
  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  void loadMockPosts() {
    _posts.clear();
    _posts.addAll([
      PostModel.mock(
        id: '1',
        imageUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Falchetron.com%2Fcdn%2Fhornwort-aa8981bf-c823-4030-8478-f4f02a85ddf-resize-750.jpeg&f=1&nofb=1&ipt=f7efe921afae2012ca39647493ede94e6a1b98ade481c755c1e314c4efab1a3b',
        speciesName: 'Anthocerotophyta',
        aiSuggested: true,
        notes: 'Seen near Trail 3',
      ),
      PostModel.mock(
        id: '2',
        imageUrl:
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.infoescola.com%2Fwp-content%2Fuploads%2F2007%2F11%2FGinkgo_biloba.jpg&f=1&nofb=1&ipt=53af8ee633836ea2f70c397630cec4e8aa2f05a24ee4fbfb85ea89626ad916c7',
        notes: 'Colorful mushroom under rock',
      ),
    ]);
    notifyListeners();
  }

  void addPost(PostModel post) {
    _posts.add(post);
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
