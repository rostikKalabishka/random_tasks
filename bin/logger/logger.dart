import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Timer.periodic(Duration(seconds: 30), (timer) async {
    try {
      final currentUser =
          '${Platform.environment['USERNAME'] ?? Platform.environment['USER']}';

      var myFile = File('C:/Users/$currentUser/Desktop/file.txt');
      var result = await Process.run('tasklist', []);
      if (result.exitCode == 0) {
        await myFile.writeAsString(result.stdout);
      } else {
        print('Command execution failure tasklist: ${result.stderr}');
      }

      print(await myFile.readAsString());
    } catch (e) {
      log(e.toString());
    }
  });
}
