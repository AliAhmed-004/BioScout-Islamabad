import 'dart:io';

import 'package:flutter/material.dart';
import '../models/post_model.dart';

class PostDetailsPage extends StatelessWidget {
  final PostModel post;

  const PostDetailsPage({super.key, required this.post});

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  bool _isAssetPath(String path) {
    return path.startsWith('assets/');
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = const SizedBox();

    if (post.imageUrl.isNotEmpty) {
      final image =
          _isNetworkUrl(post.imageUrl)
              ? Image.network(post.imageUrl)
              : _isAssetPath(post.imageUrl)
              ? Image.asset(post.imageUrl)
              : Image.file(File(post.imageUrl));

      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(height: 200, width: double.infinity, child: image),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            imageWidget,
            const SizedBox(height: 16),
            Text(
              post.speciesName ?? 'Unknown Species',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (post.aiSuggested)
              const Text(
                'AI Suggested',
                style: TextStyle(
                  color: Colors.green,
                  fontStyle: FontStyle.italic,
                ),
              ),
            const SizedBox(height: 8),
            Text(post.notes),
            const SizedBox(height: 8),
            Text(
              'Location: ${post.location}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              'Observed on: ${post.dateObserved.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
