import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_application_1/main0.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<File> _files = [];

  /// Метод выбора изображения или видео с камеры
  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    final picker = ImagePicker();
    final pickedFile = await (isVideo
        ? picker.pickVideo(source: source)
        : picker.pickImage(source: source));

    if (pickedFile != null) {
      setState(() {
        _files.add(File(pickedFile.path));
      });
    }
  }

  /// Метод выбора файлов (документы, zip, изображения и т.д.)
  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _files.addAll(result.paths.map((path) => File(path!)));
      });
    }
  }

  /// Метод отправки заявления
  void _submitReport() {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Заполните все обязательные поля')),
      );
      return;
    }

    // Здесь можно добавить логику отправки заявления на сервер
    print("Заявление отправлено");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Заявление успешно отправлено')),
    );

    // Очистка формы после отправки
    setState(() {
      _nameController.clear();
      _phoneController.clear();
      _descriptionController.clear();
      _files.clear();
    });
  }

  /// Виджет отображения загруженных файлов
  Widget _buildFilePreview(File file) {
    String fileName = file.path.split('/').last;
    bool isImage = fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg') ||
        fileName.endsWith('.png');

    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          width: 100,
          height: 100,
          child: isImage
              ? Image.file(file, fit: BoxFit.cover)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.insert_drive_file, size: 40, color: Colors.grey),
                    Text(fileName, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
        ),
        IconButton(
          icon: Icon(Icons.cancel, color: Colors.red),
          onPressed: () {
            setState(() {
              _files.remove(file);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Подача заявления'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'ФИО *'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'Телефон'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Описание происшествия *'),
            ),
            SizedBox(height: 20),

            Text('Прикрепленные файлы:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            _files.isNotEmpty
                ? Wrap(children: _files.map((file) => _buildFilePreview(file)).toList())
                : Text('Нет прикрепленных файлов'),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('Фото'),
                  onPressed: () => _pickMedia(ImageSource.camera),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.video_camera_back),
                  label: Text('Видео'),
                  onPressed: () => _pickMedia(ImageSource.camera, isVideo: true),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.attach_file),
                  label: Text('Файл'),
                  onPressed: _pickFiles,
                ),
              ],
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                child: Text('Отправить заявление'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}