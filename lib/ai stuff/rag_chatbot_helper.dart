import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RAGHelper {
  final String apiKey;
  static const String datasetFilename = 'rag_dataset.csv';

  RAGHelper(this.apiKey);

  // Ensure the CSV file exists by copying it from assets if necessary
  Future<File> _ensureDatasetExists() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$datasetFilename');

    if (!await file.exists()) {
      final byteData = await rootBundle.load('assets/rag_dataset.csv');
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    return file;
  }

  // ✅ FINAL: The updated RAG method
  Future<String> answerUserQueryWithRAG(String userQuery) async {
    final file = await _ensureDatasetExists();
    final csvData = await file.readAsString();

    final model = GenerativeModel(
      model: 'gemini-2.0-flash', // or use 'gemini-2.0-pro' for deeper answers
      apiKey: apiKey,
    );

    final prompt = '''
You are a biodiversity assistant for Islamabad and the Margalla Hills region.

The following dataset contains community-submitted observations:

$csvData

Based on this data, answer the user's question:
"$userQuery"

If relevant data isn't found, simply respond:
"I'm sorry, but I couldn't find any relevant data in my database."
''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ??
        "Sorry, I couldn't generate a response at this time.";
  }
}
