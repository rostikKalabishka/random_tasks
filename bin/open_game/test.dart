import 'dart:io';

Future<String?> findFile(String filename) async {
  List<String> directories = [
    r'C:\Program Files',
    r'C:\Program Files\SteamLibrary\steamapps\common',
    r'C:\Program Files (x86)',
    r'C:\Program Files (x86)\SteamLibrary\steamapps\common',
    r'D:\SteamLibrary\steamapps\common',
  ];

  for (var directory in directories) {
    try {
      var dir = Directory(directory);
      var entities = dir.listSync(recursive: true);

      for (var entity in entities) {
        if (entity is File && entity.uri.pathSegments.last == filename) {
          return entity.path;
        }
      }
    } catch (e) {
      print('Помилка при доступі до директорії $directory: $e');
    }
  }

  print('Файл не знайдений в зазначених директоріях.');
  return null;
}

void main() async {
  String filename = 'cs2.exe';
  String? path = await findFile(filename);

  if (path != null) {
    print('Файл знайдений за шляхом: $path');

    final process = await Process.start(path, []);
    Future.delayed(Duration(seconds: 20), () {
      process.kill();
      print('Програма завершена');
    });
  } else {
    print('Не вдалося знайти файл.');
  }
}
