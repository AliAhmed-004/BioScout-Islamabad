import 'package:bioscout/models/post_model.dart';
import 'package:bioscout/pages/home_page.dart';
import 'package:bioscout/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'hive stuff/hive_post_repository.dart';
import 'hive stuff/post_local_data_source.dart';
import 'providers/user_provider.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(PostModelAdapter());

  final postRepo = HivePostRepository(localDataSource: PostLocalDataSource());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (_) =>
                  PostProvider(repository: postRepo)
                    ..loadPosts()
                    ..loadMockPosts(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider()..loadMockUser(userId: 'u123'),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
