import 'dart:io';

import 'package:bioscout/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = const SizedBox();

    if (post.imageUrl.isNotEmpty) {
      if (_isNetworkUrl(post.imageUrl)) {
        imageWidget = Image.network(post.imageUrl, fit: BoxFit.cover);
      } else {
        imageWidget = Image.file(File(post.imageUrl), fit: BoxFit.cover);
      }
    }

    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageWidget,
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.speciesName ?? 'Unknown Species',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (post.aiSuggested)
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      'AI Suggested',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ),
                const SizedBox(height: 6),
                Text(post.notes),
                const SizedBox(height: 6),
                Text(
                  '${post.location} • ${post.dateObserved.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
