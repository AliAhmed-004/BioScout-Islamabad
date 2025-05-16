import 'package:bioscout/models/post_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.imageUrl.isNotEmpty)
            Image.network(post.imageUrl, fit: BoxFit.cover),
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
