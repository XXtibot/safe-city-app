import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'sos.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  List<File> _files = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    try {
      final XFile? pickedFile = await (isVideo
          ? _picker.pickVideo(source: source)
          : _picker.pickImage(source: source));
      if (pickedFile != null) {
        setState(() {
          _files.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      print("Ошибка при выборе медиафайла: $e");
    }
  }

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        setState(() {
          _files.addAll(result.paths.map((path) => File(path!)));
        });
      }
    } catch (e) {
      print("Ошибка при выборе файлов: $e");
    }
  }

  void _submitReport() {
    if (_nameController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Заполните все обязательные поля')),
      );
      return;
    }

    print("Заявление отправлено");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Заявление успешно отправлено')),
    );

    setState(() {
      _nameController.clear();
      _phoneController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _files.clear();
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SOSScreen()),
    );
  }

  Widget _buildFilePreview(File file) {
    String fileName = file.path.split('/').last.toLowerCase();
    bool isImage = fileName.endsWith('.jpg') ||
        fileName.endsWith('.jpeg') ||
        fileName.endsWith('.png');
    bool isVideo = fileName.endsWith('.mp4') ||
        fileName.endsWith('.mov') ||
        fileName.endsWith('.avi');

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(right: 10, top: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: isImage
                ? Image.file(file, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isVideo ? Icons.video_library : Icons.insert_drive_file,
                          size: 40,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 5),
                        Text(
                          fileName.length > 10
                              ? '${fileName.substring(0, 7)}...'
                              : fileName,
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        Positioned(
          right: 5,
          top: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _files.remove(file);
              });
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Icon(Icons.close, size: 20, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Сообщить о происшествии',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Описание происшествия',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Опишите, что произошло...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Местоположение',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Укажите адрес происшествия',
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Прикрепленные файлы',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () => _pickMedia(ImageSource.camera),
                      tooltip: 'Сделать фото',
                    ),
                    IconButton(
                      icon: Icon(Icons.video_camera_back),
                      onPressed: () => _pickMedia(ImageSource.camera, isVideo: true),
                      tooltip: 'Снять видео',
                    ),
                    IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: _pickFiles,
                      tooltip: 'Прикрепить файл',
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            _files.isEmpty
                ? Center(
                    child: Text(
                      'Нет прикрепленных файлов',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _files.map((file) => _buildFilePreview(file)).toList(),
                  ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Отправить',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }
} 