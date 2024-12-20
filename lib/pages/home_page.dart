import 'package:flutter/material.dart';
import 'package:spark/components/my_button.dart';


import 'load_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _urlController = TextEditingController();
  String _errorMessage = '';

  GlobalKey<FormState> _key = GlobalKey<FormState>();


  final RegExp _urlPattern = RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');


  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a URL';
    } else if (!_urlPattern.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
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
                              validator: _validateUrl,
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
