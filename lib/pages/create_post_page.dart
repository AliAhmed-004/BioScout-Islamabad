import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../providers/post_provider.dart';
import '../providers/user_provider.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final speciesController = TextEditingController();
  final locationController = TextEditingController();
  final notesController = TextEditingController();
  bool aiSuggested = false;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void submitPost() {
    final userId = context.read<UserProvider>().currentUser.id;

    final newPost = PostModel.mock(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      imageUrl: _selectedImage?.path ?? '', // ✅ Use local path if selected
      speciesName:
          speciesController.text.isNotEmpty ? speciesController.text : null,
      aiSuggested: aiSuggested,
      location:
          locationController.text.isNotEmpty
              ? locationController.text
              : 'Margalla Hills',
      notes: notesController.text,
      userId: userId,
    );

    context.read<PostProvider>().addPost(newPost);
    context.read<UserProvider>().incrementPostCountFor(userId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: speciesController,
              decoration: const InputDecoration(
                labelText: 'Species Name (optional)',
              ),
            ),
            SwitchListTile(
              title: const Text('AI Suggested?'),
              value: aiSuggested,
              onChanged: (val) => setState(() => aiSuggested = val),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Select Image'),
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(_selectedImage!, height: 200),
              ),

            ElevatedButton(
              onPressed: submitPost,
              child: const Text('Submit Observation'),
            ),
          ],
        ),
      ),
    );
  }
}
