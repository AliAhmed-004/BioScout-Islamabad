import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/user_provider.dart';
import '../pages/post_details_page.dart'; // Create this page

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({super.key, required this.post});

  bool _isNetworkUrl(String url) {
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().getUserById(post.userId);

    Widget imageWidget = const SizedBox();
    if (post.imageUrl.isNotEmpty) {
      final image =
          _isNetworkUrl(post.imageUrl)
              ? Image.network(post.imageUrl, fit: BoxFit.cover)
              : Image.file(File(post.imageUrl), fit: BoxFit.cover);

      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(width: 80, height: 80, child: image),
      );
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => PostDetailsPage(post: post)),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Left: Thumbnail Image
              if (post.imageUrl.isNotEmpty) imageWidget,
              if (post.imageUrl.isNotEmpty) const SizedBox(width: 10),

              // Right: Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Poster name and date
                    Row(
                      children: [
                        Text(
                          user?.name ?? 'Unknown',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Text(
                          post.dateObserved.toLocal().toString().split(' ')[0],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Species name and AI tag
                    Text(
                      post.speciesName ?? 'Unknown Species',
                      style: const TextStyle(fontSize: 15),
                    ),
                    if (post.aiSuggested)
                      const Text(
                        'AI Suggested',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    const SizedBox(height: 4),

                    // Truncated Notes
                    Text(
                      post.notes,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),

                    const SizedBox(height: 4),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.place, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          post.location,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
