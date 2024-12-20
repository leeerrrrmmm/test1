import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:spark/API/response.dart';
import 'package:spark/components/my_button.dart';
import 'package:spark/model/some_model.dart';

import 'load_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _urlController = TextEditingController();
  Responses _responses = Responses();
  List<DataItem> _data = [];
  bool _isLoading = false;
  String _errorMessage = '';
  double _progress = 0.0;

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Регулярное выражение для проверки URL
  final RegExp _urlPattern = RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');

  // Функция для проверки URL
  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL'; // Сообщение, если поле пустое
    } else if (!_urlPattern.hasMatch(value)) {
      return 'Please enter a valid URL'; // Сообщение, если формат неправильный
    }
    return null; // URL валиден
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Home screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Set a valid API base URL in order to continue'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.compare_arrows,
                          color: Colors.grey.shade500,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: _urlController,
                              validator: _validateUrl, // Применяем валидатор
                              decoration: InputDecoration(
                                labelText: 'Url...',
                                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              MyButton(
                onPressed: () {
                  if (_key.currentState?.validate() ?? false) {
                    // Если форма валидна, переходим на другую страницу
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadPage(
                          url: _urlController.text.trim(),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      // Если ошибка, показываем сообщение
                      _errorMessage = 'Please fix the errors in the form.';
                    });
                  }
                },
                label: 'Start counting process',
                color: Colors.lightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
