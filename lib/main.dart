import 'package:bioscout/pages/home_page.dart';
import 'package:bioscout/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PostProvider()..loadMockPosts()),
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
