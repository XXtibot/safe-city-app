import 'package:flutter/material.dart';
import 'package:flutter_application_1/main0.dart';
import 'package:flutter_application_1/map.dart' as map;
import 'package:flutter_application_1/chat.dart' as chat;

class HelpOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0E57),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
        ),
        title: Text(
          'Помощь и поддержка',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Выберите вариант связи',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Как вы хотите связаться с оператором?',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),

            // Кнопка "Чат с оператором"
            _buildOptionButton(
              context,
              icon: Icons.chat_bubble_outline,
              label: 'Чат с оператором',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => chat.MyAppChat()),
                );
              },
            ),

            SizedBox(height: 15),

            // Кнопка "Ближайшие пункты полиции"
            _buildOptionButton(
              context,
              icon: Icons.location_on_outlined,
              label: 'Ближайшие пункты полиции',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => map.MyAppMap()),
                );
              },
            ),

            SizedBox(height: 15),

            // Кнопка "Аудиозвонок / Видеозвонок с оператором"
            _buildOptionButton(
              context,
              icon: Icons.video_call_outlined,
              label: 'Аудио/видео-звонок с оператором',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 24),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
