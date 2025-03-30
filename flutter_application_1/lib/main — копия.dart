import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru', 'RU'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  final Map<String, String> _botResponses = {
    "привет": "Здравствуйте! Как я могу помочь?",
    "как дела?": "Я просто программа, но у меня всё отлично! А у вас?",
    "что ты умеешь?": "Я могу отвечать на ваши вопросы. Задайте что-нибудь!",
    "пока": "До свидания! Хорошего дня!",
    "кто ты?": "Я чат-бот, созданный для помощи вам!",
    "что делать если украли вещь?": "Рекомендую обратиться в полицию и написать заявление о краже.",
    "как подать жалобу?": "Вы можете подать жалобу через официальный сайт или обратиться в службу поддержки.",
    "как вернуть деньги?": "Если покупка была совершена онлайн, попробуйте оформить возврат или обратиться в банк.",
    "как найти работу?": "Попробуйте использовать сайты вакансий, например hh.ru или LinkedIn.",
    "как записаться к врачу?": "Записаться можно через портал государственных услуг или по телефону поликлиники.",
    "что делать если потерял документы?": "Обратитесь в ближайший МФЦ или полицию, чтобы восстановить документы.",
    "как оформить визу?": "Для оформления визы вам нужно обратиться в консульство или визовый центр.",
    "как забронировать отель?": "Вы можете использовать сервисы бронирования, например Booking или Airbnb.",
    "как отправить посылку?": "Вы можете воспользоваться услугами почты или курьерских служб, таких как DHL или СДЭК.",
    "как получить гражданство?": "Процесс получения гражданства зависит от страны. Обычно требуется подать заявление и документы в миграционную службу."
  };

  void _sendMessage() {
    String userMessage = _controller.text.toLowerCase().trim();
    if (userMessage.isNotEmpty) {
      setState(() {
        _messages.add({"user": _controller.text});
        _controller.clear();
      });
      _botReply(userMessage);
    }
  }

  void _botReply(String userMessage) {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        String botResponse = _botResponses[userMessage] ?? "Извините, я не понимаю. Попробуйте задать другой вопрос.";
        _messages.add({"bot": botResponse});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Чат с оператором"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.containsKey("user");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Card(
                    color: isUser ? Colors.blue[100] : Colors.white,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        isUser ? message["user"]! : message["bot"]!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Введите сообщение...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
