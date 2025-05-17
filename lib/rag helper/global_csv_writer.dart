import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/post_model.dart';

class GlobalCSVStore {
  static Future<File> _getCSVFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/big_dataset.csv');
  }

  static Future<void> appendPost(PostModel post) async {
    final file = await _getCSVFile();
    final exists = await file.exists();

    final row = [
      post.speciesName ?? '',
      post.location,
      post.notes,
      post.aiSuggested ? 'yes' : 'no',
      post.dateObserved.toIso8601String(),
    ];

    final csvLine = const ListToCsvConverter().convert([row]);

    if (!exists) {
      // write header + first row
      final header = [
        'speciesName',
        'location',
        'notes',
        'aiSuggested',
        'dateObserved',
      ];
      final headerLine = const ListToCsvConverter().convert([header]);
      await file.writeAsString('$headerLine\n$csvLine\n');
    } else {
      // just append new row
      await file.writeAsString('$csvLine\n', mode: FileMode.append);
    }
  }

  static Future<String> readEntireCSV() async {
    final file = await _getCSVFile();
    return file.existsSync() ? file.readAsString() : '';
  }
}
