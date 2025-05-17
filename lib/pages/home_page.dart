import 'package:bioscout/pages/create_post_page.dart';
import 'package:bioscout/pages/profile_page.dart';
import 'package:bioscout/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import '../components/post_card.dart';
import 'rag_chatbot_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = context.watch<PostProvider>().posts;
    final currentUser = context.watch<UserProvider>().currentUser;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('BioScout Islamabad'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatPage()),
              );
            },
            child: const Text('Open Biodiversity Chatbot'),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          child: CircleAvatar(child: Image.network(currentUser.avatarUrl)),
        ),
      ),

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
