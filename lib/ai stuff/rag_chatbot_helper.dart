import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RAGHelper {
  final String apiKey;
  static const String datasetFilename = 'rag_dataset.csv';
  static const List<String> snippetPaths = [
    'assets/snippets/1.txt',
    'assets/snippets/2.txt',
    'assets/snippets/3.txt',
    'assets/snippets/4.txt',
    'assets/snippets/5.txt',
  ];

  RAGHelper(this.apiKey);

  Future<File> _ensureDatasetExists() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$datasetFilename');

    if (!await file.exists()) {
      final byteData = await rootBundle.load('assets/rag_dataset.csv');
      await file.writeAsBytes(byteData.buffer.asUint8List());
    }

    return file;
  }

  // ✅ Load snippet files from assets
  Future<String> loadAllSnippets() async {
    final buffer = StringBuffer();
    for (final path in snippetPaths) {
      try {
        print("Trying to load: $path");
        final snippet = await rootBundle.loadString(path);
        buffer.writeln(snippet.trim());
        buffer.writeln(); // blank line between snippets
        print("✅ Loaded snippet from: $path");
      } catch (e) {
        print("❌ Failed to load: $path → $e");
      }
    }

    final combined = buffer.toString().trim();
    print("📦 Total snippet length: ${combined.length}");
    return combined;
  }

  // ✅ Full RAG query
  Future<String> answerUserQueryWithRAG(String userQuery) async {
    final file = await _ensureDatasetExists();
    final csvData = await file.readAsString();
    final snippetData = await loadAllSnippets();

    final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

    print("Snipped Data: $snippetData");

    final prompt = '''
You are a biodiversity assistant focused on Islamabad and the Margalla Hills.

Use the information below to answer the user's question **as naturally and conversationally as possible**, like an experienced guide or conservationist would.

---

🧠 **Expert Notes (from conservation organizations):**
$snippetData

📦 **Community Observations (reported sightings and notes):**
$csvData

---

Guidelines for answering:

1. Provide helpful, factual, and natural responses. Do **not** mention "dataset", "CSV", or how you're generating your answer.
2. If the user's exact species or plant is not found, still try to help:
   - Look for semantically similar species
   - Offer the closest matching information
   - Example: If asked about *cheetahs*, and you only know about *leopards*, respond like:  
     “I don't have information about cheetahs here, but leopards have been seen in the region...”
3. Be clear, helpful, and friendly. If there's absolutely no relevant info, say:  
   “I don’t have any knowledge about that right now, but I’ll keep an eye out.”

---

Now answer the user's question:
"$userQuery"
''';

    print("FINAL PROMPT:\n$prompt");

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ??
        "Sorry, I couldn't generate a response at this time.";
  }
}
