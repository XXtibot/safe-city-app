import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/police.dart';

void main() {
  runApp(const MyAppChat());
}

class MyAppChat extends StatelessWidget {
  const MyAppChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru', 'RU'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
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
    "жалоба": "Вы можете подать жалобу через официальный сайт или обратиться в службу поддержки.",
    "украли": "Рекомендую обратиться в полицию и написать заявление о краже.",
    "деньги": "Если покупка была совершена онлайн, попробуйте оформить возврат или обратиться в банк.",
    "работа": "Попробуйте использовать сайты вакансий, например hh.ru или LinkedIn.",
    "врач": "Записаться можно через портал госуслуг или по телефону поликлиники.",
    "документы": "Обратитесь в МФЦ или полицию, чтобы восстановить документы.",
    "виза": "Для оформления визы обратитесь в консульство или визовый центр.",
    "отель": "Вы можете использовать сервисы бронирования, например Booking или Airbnb.",
    "посылка": "Воспользуйтесь услугами почты или курьерских служб, таких как DHL или СДЭК.",
    "гражданство": "Процесс получения гражданства зависит от страны. Обычно требуется подать заявление и документы в миграционную службу."
  };

  @override
  void initState() {
    super.initState();
    _sendInitialMessage();
  }

  void _sendInitialMessage() {
    setState(() {
      _messages.add({
        "bot": "Привет! Вы можете задать вопросы по следующим темам:\n- Жалоба\n- Украли\n- Деньги\n- Работа\n- Врач\n- Документы\n- Виза\n- Отель\n- Посылка\n- Гражданство"
      });
    });
  }

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
        String bestMatch = "Извините, я не понимаю. Попробуйте задать другой вопрос.";
        int minDistance = userMessage.length;

        _botResponses.forEach((key, value) {
          int distance = _levenshteinDistance(userMessage, key);
          if (distance < minDistance) {
            minDistance = distance;
            bestMatch = value;
          }
        });

        _messages.add({"bot": bestMatch});
      });
    });
  }

  int _levenshteinDistance(String a, String b) {
    List<List<int>> dp = List.generate(
      a.length + 1,
      (i) => List.filled(b.length + 1, 0),
    );

    for (int i = 0; i <= a.length; i++) {
      for (int j = 0; j <= b.length; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else {
          int cost = (a[i - 1] == b[j - 1]) ? 0 : 1;
          dp[i][j] = [
            dp[i - 1][j] + 1,
            dp[i][j - 1] + 1,
            dp[i - 1][j - 1] + cost
          ].reduce((a, b) => a < b ? a : b);
        }
      }
    }
    return dp[a.length][b.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpOptionsScreen()),
                );
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
