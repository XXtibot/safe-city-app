import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'sos.dart';
import 'dart:io';

class UserData {
  final String? name;
  final String? surname;
  final DateTime? birthDate;
  final String? phone;
  final String? email;
  final String? iin;
  final String? gender;
  final File? imageFile;

  UserData({
    this.name,
    this.surname,
    this.birthDate,
    this.phone,
    this.email,
    this.iin,
    this.gender,
    this.imageFile,
  });
}

class UserProfileScreen extends StatelessWidget {
  final UserData userData;

  UserProfileScreen({required this.userData});

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    List<String> months = [
      'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year} г.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ваши данные',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  backgroundImage: userData.imageFile != null ? FileImage(userData.imageFile!) : null,
                  child: userData.imageFile == null
                      ? Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 40),
              _buildInfoField("Имя:", "${userData.name} ${userData.surname}"),
              const SizedBox(height: 20),
              _buildInfoField("Пол:", userData.gender ?? ''),
              const SizedBox(height: 20),
              _buildInfoField("Дата рождения:", _formatDate(userData.birthDate)),
              const SizedBox(height: 20),
              _buildInfoField("Номер телефона:", userData.phone ?? ''),
              const SizedBox(height: 20),
              _buildInfoField("Email:", userData.email ?? ''),
              const SizedBox(height: 20),
              _buildInfoField("ИИН:", userData.iin ?? ''),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(userData: userData),
                          ),
                        );
                        if (result != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(userData: result),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Изменить данные',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: BorderSide(color: Colors.blue),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SOSScreen()),
                        );
                      },
                      child: Text(
                        'Завершить регистрацию',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: Text(
                  'SafeCity',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xFF000080),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}