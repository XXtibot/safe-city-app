import 'package:flutter/material.dart';
import 'package:flutter_application_1/statement.dart';
import 'package:flutter_application_1/police.dart';
import 'package:flutter_application_1/news.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmergencyScreen(),
    );
  }
}

class EntranceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Экран входа',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}



class EmergencyScreen extends StatelessWidget {

  void _callEmergencyNumber() async {
    final Uri emergencyUri = Uri.parse('tel:102');

    if (await canLaunchUrl(emergencyUri)) {
      await launchUrl(emergencyUri, mode: LaunchMode.externalApplication);
    } else {
      print("Не удалось совершить звонок");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NewsScreen()), // Замени на свой экран с новостями
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()), // Замени на свой экран с услугами
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()), // Замени на свой экран профиля
        );
        break;
    }
  },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Услуги',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
      body: Column(
        children: [
          // Верхний блок
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF0A0E57),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => EntranceScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.account_circle, color: Colors.white, size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Имя Фамилия', style: TextStyle(color: Colors.white, fontSize: 16)),
                              Text('Полный профиль', style: TextStyle(color: Colors.red, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.red),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => EntranceScreen()),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('RU', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EntranceScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Не определено', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 5),
                      Text('Моё местоположение', style: TextStyle(color: Colors.red)),
                      Icon(Icons.location_on, color: Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Текст + кнопка SOS
          Text(
            'Нужна экстренная помощь?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            'Нажмите кнопку для вызова',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 30),

          // Кнопка SOS с обводкой
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _callEmergencyNumber,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(80),
                  ),
                  child: Text(
                    'SOS',
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),

          // Блок с вопросом и кнопками
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Text(
                  'Не уверены, что делать?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Выберите тему для чата', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 20),

                // Кнопки "Полиция" и "Сообщить о происшествии"
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HelpOptionsScreen()),
                            );
                          },
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
                              Text('👮', style: TextStyle(fontSize: 18)),
                              SizedBox(width: 8),
                              Text(
                                'Полиция',
                                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ReportScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, color: Colors.grey, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Сообщить о',
                                    style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2),
                              Text(
                                'происшествии',
                                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
        ],
      ),
    );
  }
}
