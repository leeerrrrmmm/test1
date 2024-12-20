import 'dart:convert';

import 'package:spark/model/some_model.dart';
import 'package:http/http.dart' as http;
class Responses {


  Future<ApiResponse> fetchData(String url) async {
   try{
     final response = await http.get(
         Uri.parse(url)
     );

     if(response.statusCode == 429){
       throw Exception('Too Many Requests');
     }else if(response.statusCode == 500){
       throw Exception('Internal Server Error');
     }else if(response.statusCode == 200){
       return ApiResponse.fromJson(jsonDecode(response.body));
     }else{
       throw Exception('Failed to load data');
     }
   }catch (e) {
     throw  Exception('Error: $e');
   }
  }

  Future<void> sendRes(String url,List<Map<String, dynamic>> data ) async{
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-type' : 'application/json'
        },
        body: jsonEncode(data)
      );
      if(response.statusCode == 200){
        print('Result sent successfuly');
      }else{
        throw Exception('Error send data');
      }

    }catch (e) {
      throw Exception('Error: $e');
    }
  }
}