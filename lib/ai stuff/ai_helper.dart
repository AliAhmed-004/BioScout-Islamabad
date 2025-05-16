import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIHelper {
  final String apiKey;

  AIHelper(this.apiKey);

  Future<Map<String, String>> analyzeImage(File imageFile) async {
    final model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);

    final imageBytes = await imageFile.readAsBytes();
    final content = [
      Content.multi([
        DataPart('image/jpeg', imageBytes),
        TextPart(
          'You are a biodiversity assistant. Identify the species in this image and return:\n'
          '1. The common or scientific name of the species.\n'
          '2. A 3-line note describing it, focusing on location, appearance, or danger level.\n'
          'Respond in the format:\n'
          'Name: <species name>\nNotes: <3-line note>',
        ),
      ]),
    ];

    final response = await model.generateContent(content);
    final text = response.text ?? '';

    final lines = text.split('\n');
    final nameLine = lines.firstWhere(
      (line) => line.toLowerCase().startsWith('name:'),
      orElse: () => '',
    );
    final notesLines =
        lines
            .where(
              (line) =>
                  line.toLowerCase().startsWith('notes:') ||
                  line.trim().isNotEmpty,
            )
            .skip(1)
            .toList();

    return {
      'species': nameLine.replaceFirst('Name:', '').trim(),
      'notes': notesLines.join('\n').replaceFirst('Notes:', '').trim(),
    };
  }
}
