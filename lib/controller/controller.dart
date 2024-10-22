import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spelling_game/constant/all_words.dart';
import 'package:flutter_spelling_game/widgets/message_box.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Controller extends ChangeNotifier {
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;
  bool generateWord = true, sessionCompleted = false, letterDropped = false;
  double percentCompleted = 0;
  final AudioPlayer _audioPlayer = AudioPlayer(); // AudioPlayer instance

  setUp({required int total}) {
    lettersAnswered = 0;
    totalLetters = total;
    notifyListeners();
  }

  Future<void> playSound(String assetFile) async {
    try {
      // Geçici dizini al
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$assetFile';

      final file = File(filePath);

      // Eğer dosya yoksa, asset'ten kopyala
      if (!file.existsSync()) {
        final data = await rootBundle.load(assetFile);
        final bytes = data.buffer.asUint8List();
        await file.writeAsBytes(bytes, flush: true);
      }

      // Cihaz dosyasını oynatmak için Source tipinde veri gönder
      await _audioPlayer.setSource(DeviceFileSource(filePath));
      _audioPlayer.play(DeviceFileSource(filePath));
    } catch (e) {
      print("Error playing sound: $e");
    }
  }

  incrementLetters({required BuildContext context}) async {
    lettersAnswered++;
    updateLetterDropped(dropped: true);
    if (lettersAnswered == totalLetters) {
      await playSound('audio/Correct_2.mp3'); // Doğru ses dosyasını çal
      wordsAnswered++;
      percentCompleted = wordsAnswered / allWords.length;
      if (wordsAnswered == allWords.length) {
        sessionCompleted = true;
      }
      showDialog(
          barrierDismissible: false,
          context: context, // Pass the context here
          builder: (_) => MessageBox(
                sessionCompleted: sessionCompleted,
              ));
    } else {
      await playSound('audio/Correct_1.mp3'); // Diğer ses dosyasını çal
    }
    notifyListeners();
  }

  requestWord({required bool request}) {
    generateWord = request;
    notifyListeners();
  }

  updateLetterDropped({required bool dropped}) {
    letterDropped = dropped;
    notifyListeners();
  }

  reset() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
  }
}
