import 'dart:math';
import 'package:flutter/material.dart';

class ResultList extends StatelessWidget {
  final Point<int> start;
  final Point<int> end;

  ResultList({required this.start, required this.end});


  List<Point<int>> findShortestPath(Point<int> start, Point<int> end) {
    List<Point<int>> path = [];
    int x = start.x;
    int y = start.y;

    while (x != end.x || y != end.y) {
      path.add(Point(x, y));


      if (x != end.x && y != end.y) {
        x += (end.x > x) ? 1 : -1;
        y += (end.y > y) ? 1 : -1;
      }

      else if (x != end.x) {
        x += (end.x > x) ? 1 : -1;
      }

      else if (y != end.y) {
        y += (end.y > y) ? 1 : -1;
      }
    }

    path.add(end);
    return path;
  }

  @override
  Widget build(BuildContext context) {

    const int gridSize = 4;


    final path = findShortestPath(start, end);

    String pathString = path.map((point) => '(${point.x}, ${point.y})').join(' -> ');

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue,
        iconTheme: IconThemeData(
        color:Colors.white
      ),
        title: Text(pathString,
        style:TextStyle(
          color:Colors.white
        )),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
            ),
            itemCount: gridSize * gridSize,
            itemBuilder: (context, index) {

              int x = index % gridSize;
              int y = index ~/ gridSize;
              Point<int> currentPoint = Point(x, y);


              Color cellColor;
              if (currentPoint == start) {
                cellColor = Color(0xFF64FFDA);
              } else if (currentPoint == end) {
                cellColor = Color(0xFF009688);
              } else if (path.contains(currentPoint)) {
                cellColor = Color(0xFF4CAF50);
              } else {
                cellColor = Color(0xFFFFFFFF);
              }

              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: cellColor,
                  border: Border.all(color: Colors.black),
                ),
                child: Text(
                  '($x, $y)',
                  style: TextStyle(
                    color: cellColor == Color(0xFF000000) ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
