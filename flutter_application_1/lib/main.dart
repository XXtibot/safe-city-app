import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'entrance.dart';

void main() {
  runApp(SafeCityApp());
}

class SafeCityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ru', 'RU'),
      ],
      locale: const Locale('ru', 'RU'),
      home: LoginScreen(),
    );
  }
}

class SafeCityWelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Добро пожаловать в',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            Text(
              'SafeCity',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            buildPermissionItem(
              context,
              1,
              'Камера',
              'Для фиксации правонарушений и отправки фото или видео в полицию приложению необходим доступ к камере.',
              Icons.camera_alt,
              Permission.camera,
              buttonWidth,
            ),
            buildPermissionItem(
              context,
              2,
              'Геолокация',
              'Для оперативного определения вашего местоположения при обращении в полицию требуется разрешение на использование геолокации.',
              Icons.location_on,
              Permission.location,
              buttonWidth,
            ),
            buildPermissionItem(
              context,
              3,
              'Микрофон',
              'Для записи голосовых сообщений, звонков и передачи аудиоматериалов в полицию приложению необходим доступ к микрофону.',
              Icons.mic,
              Permission.microphone,
              buttonWidth,
            ),
            buildPermissionItem(
              context,
              4,
              'Файлы',
              'Для прикрепления фото, видео и документов при подаче обращений в полицию приложению требуется доступ к памяти устройства.',
              Icons.insert_drive_file,
              Permission.storage,
              buttonWidth,
            ),
            Spacer(),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EntranceScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Продолжить',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPermissionItem(
    BuildContext context,
    int number,
    String title,
    String description,
    IconData icon,
    Permission permission,
    double buttonWidth,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    radius: 22,
                    child: Icon(icon, color: Colors.blue, size: 24),
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 10,
                      child: Text(
                        '$number',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            width: buttonWidth,
            child: OutlinedButton(
              onPressed: () async {
                var status = await permission.request();
                if (status.isGranted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title разрешено!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title не разрешено!')),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Разрешить', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
    );
  }
}
