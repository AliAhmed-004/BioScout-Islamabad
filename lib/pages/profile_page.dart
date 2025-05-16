import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/post_card.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.currentUser;
    final users = userProvider.users.values.toList();

    final allPosts = context.watch<PostProvider>().posts;
    final userPosts = allPosts.where((post) => post.userId == user.id).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Your Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar + Name
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(height: 10),
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Post Count
              Text(
                'Posts made: ${user.postCount}',
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 20),

              // Badges
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Badges',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              if (user.badges.isEmpty)
                const Text('No badges earned yet.')
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      user.badges.map((badge) {
                        return Chip(
                          label: Text(badge),
                          avatar: const Icon(
                            Icons.emoji_events,
                            color: Colors.amber,
                          ),
                          backgroundColor: Colors.amber.shade100,
                        );
                      }).toList(),
                ),

              const SizedBox(height: 20),

              // User Switcher (Optional for testing)
              if (users.length > 1)
                Column(
                  children: [
                    const Divider(),
                    const Text('Switch User (for demo)'),
                    DropdownButton<String>(
                      value: user.id,
                      items:
                          users.map((u) {
                            return DropdownMenuItem(
                              value: u.id,
                              child: Text(u.name),
                            );
                          }).toList(),
                      onChanged: (newId) {
                        if (newId != null) {
                          context.read<UserProvider>().switchUser(newId);
                        }
                      },
                    ),
                  ],
                ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Observations',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 8),
              if (userPosts.isEmpty)
                const Text('No posts yet.')
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: userPosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(post: userPosts[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
