import 'package:flutter/material.dart';
import 'package:spark/components/my_button.dart';
import 'list.dart';

class LoadPage extends StatefulWidget {
  final String url;

  const LoadPage({
    super.key,
    required this.url,
  });

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  double _progress = 0.0;
  bool _isLoading = false;


  Future<void> loadProgress() async {
    try {
      setState(() {
        _progress = 0.0;
        _isLoading = true;
      });

      // Симуляция загрузки данных
      for (int i = 0; i <= 100; i++) {
        await Future.delayed(Duration(milliseconds: 50));
        setState(() {
          _progress = i / 100;
        });
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Progress screen',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isLoading
                        ?
                    'Wait until the count is complete...'
                        :
                    'All calculations have finished, you can send your results to the server.',
                    style: TextStyle(fontSize: 21),
                    textAlign: TextAlign.center,
                  ),
                  // Text(
                  //  widget.url,
                  //   style: TextStyle(fontSize: 21),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 20),
                  Text(
                    '${(_progress * 100).toStringAsFixed(0)}%',
                    style: TextStyle(fontSize: 21),
                  ),
                  SizedBox(height: 30),
                  CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 4,
                    strokeAlign: 10,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: MyButton(
                onPressed:_isLoading
                    ?
                null
                    :
                    () {
                  Navigator.of(context)
                      .push((MaterialPageRoute(builder:(context) => ListScreen(url: widget.url,))),
                  );
                  },
                label:  _isLoading ? 'Wait for end progress' : 'Send results to server',
                color: _isLoading ? Colors.lightBlueAccent.shade200 : Colors.lightBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
