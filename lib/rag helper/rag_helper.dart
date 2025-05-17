import 'dart:io';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:path_provider/path_provider.dart';
import '../models/post_model.dart';

class RAGChatBotHelper {
  final String apiKey;

  RAGChatBotHelper(this.apiKey);

  // Name of copied CSV file on the device
  static const String datasetFilename = 'rag_dataset.csv';

  // Step 1: Copy initial CSV from assets if needed
  Future<File> _ensureDatasetExists() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$datasetFilename');

    if (!await file.exists()) {
      final byteData = await rootBundle.load('assets/rag_dataset.csv');
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    return file;
  }

  // Step 2: Append new post to dataset
  Future<void> appendPostToDataset(PostModel post) async {
    final file = await _ensureDatasetExists();

    final row = [
      post.speciesName ?? '',
      post.location,
      post.notes,
      post.aiSuggested ? 'yes' : 'no',
      post.dateObserved.toIso8601String(),
    ];

    final csvLine = const ListToCsvConverter().convert([row]);
    await file.writeAsString('$csvLine\n', mode: FileMode.append);
  }

  // Step 3: Read full dataset as a string
  Future<String> getFullDatasetCSV() async {
    final file = await _ensureDatasetExists();
    return await file.readAsString();
  }

  // Step 4: Answer user question using RAG (CSV in prompt)
  Future<String> answerUserQueryWithRAG(String userQuery) async {
    final csvData = await getFullDatasetCSV();

    final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

    final prompt = '''
You are a biodiversity assistant for Islamabad and the Margalla Hills.

The following dataset contains community-submitted observations:

$csvData

Using this information, answer the user's question:
"$userQuery"
''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ??
        "Sorry, I couldn't generate a response right now.";
  }
}
