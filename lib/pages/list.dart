import 'dart:math';
import 'package:flutter/material.dart';
import 'package:spark/API/response.dart';
import 'package:spark/model/some_model.dart';
import 'package:spark/pages/result_list.dart';


class ListScreen extends StatefulWidget {
  final String url;
  ListScreen({
    super.key,
    required this.url,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Responses _responses = Responses();
  List<DataItem> _data = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Point<int>> fetchShortestPath(Point<int> start, Point<int> end){
    List<Point<int>> path = [];
    int x = start.x;
    int y = start.y;

    while(x != end.x || y != end.y){
      path.add(Point(x, y));

      if(x != end.x && y != end.y){
        x += (end.x > x) ? 1 : -1;
        y += (end.y > y) ? 1 : -1;
      }else if(x != end.x){
        x += (end.x > x) ? 1 : -1;
      }else if(y != end.y){
        y += (end.y > y) ? 1 : -1;
      }
    }

    path.add(end);
    return path;
  }

  Future<void> fetchDataFromApi() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      final response = await _responses.fetchData(widget.url);
      setState(() {
        _isLoading = false;
        _data = response.data;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi(); // Загружаем данные при старте
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue,
        iconTheme:IconThemeData(
          color:Colors.white
        ),
        title: Text('Result list screen',
        style:TextStyle(
          color:Colors.white
        )),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          final data = _data[index];
          final Point<int> start = Point(data.start.x, data.start.y);
          final Point<int> end = Point(data.end.x, data.end.y);

          final path = fetchShortestPath(start, end);

          final String showShortestPath = path.map((item) => '(${item.x} , ${item.y})')
              .join(' -> ');

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: ListTile(
                title: Text(showShortestPath,
                textAlign: TextAlign.center,),
                onTap: () {
                  // При нажатии передаем данные в новый экран
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultList(start: start, end: end),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
