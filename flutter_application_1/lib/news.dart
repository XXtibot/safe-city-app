import 'package:flutter/material.dart';
import 'package:flutter_application_1/main%20%E2%80%94%20%D0%BA%D0%BE%D0%BF%D0%B8%D1%8F%20(2).dart';
import 'package:flutter_application_1/main0.dart' as main1;


class NewsScreen extends StatelessWidget {
  final List<Map<String, String>> newsList = [
    {
      'title': 'Взрыв на шахте имени Костенко',
      'description': 'В ночь на 28 октября 2023 года на шахте имени Костенко произошёл взрыв и пожар, в результате которого погибли 46 шахтёров.',
    },
    {
      'title': 'Убийство Салтанат Нукеновой',
      'description': 'Бывший министр экономики Казахстана Куандык Бишимбаев обвиняется в убийстве своей гражданской жены Салтанат Нукеновой.',
    },
    {
      'title': 'Мошенничество с лотереей в ЗКО',
      'description': 'Житель Атырауской области обманывал граждан, представляясь представителем лотереи и сообщая о несуществующих выигрышах.',
    },
    {
      'title': 'Задержание разыскиваемых преступников',
      'description': 'С начала года оперативными службами МВД задержано 58 преступников, включая разыскиваемых за тяжкие и особо тяжкие преступления.',
    },
    {
      'title': 'Кража денежных средств в Караганде',
      'description': 'Мужчина похитил 160 тысяч тенге со счета знакомого, воспользовавшись его мобильным телефоном.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Новости', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                newsList[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(newsList[index]['description']!),
              onTap: () {},
            ),
          );
        },
      ),
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
                MaterialPageRoute(builder: (context) => main1.MyApp()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NewsScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => main1.MyApp()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => main1.MyApp()),
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
    );
  }
}
