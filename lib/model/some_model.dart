
class ApiResponse {
  final bool error;
  final String message;
  final List<DataItem> data;

  ApiResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => DataItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DataItem {
  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  DataItem({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) {
    return DataItem(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Coordinate.fromJson(json['start']),
      end: Coordinate.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

class Coordinate {
  final int x;
  final int y;

  Coordinate({
    required this.x,
    required this.y,
  });

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
