import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import 'components/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostProvider>().posts;

    return Scaffold(
      appBar: AppBar(title: const Text('BioScout Islamabad')),
      body:
          posts.isEmpty
              ? const Center(child: Text('No observations yet.'))
              : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostCard(post: post);
                },
              ),
    );
  }
}
