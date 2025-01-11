import 'dart:io';

void main() async {
  String imagePath = r'C:\Users\pain3\Pictures\test111.jpg';

  var result = await Process.run('reg', [
    'add',
    'HKEY_CURRENT_USER\\Control Panel\\Desktop',
    '/v',
    'Wallpaper',
    '/t',
    'REG_SZ',
    '/d',
    imagePath,
    '/f'
  ]);

  var updateResult = await Process.run(
      'RUNDLL32.EXE', ['user32.dll,UpdatePerUserSystemParameters']);

  if (result.exitCode == 0 && updateResult.exitCode == 0) {
    print('Фон змінено!');
  } else {
    print('Помилка: ${result.stderr}');
  }
}
