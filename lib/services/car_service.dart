import 'dart:convert';

import 'package:indocars/endpoints/Endpoint.dart';
import 'package:indocars/models/car.dart';
import 'package:http/http.dart' as http;
import 'package:indocars/services/upload_image.dart';
import 'dart:typed_data';

class CarService {
  static Future<bool> insertCar(Car car, List<Uint8List> files) async {
    List<String> urls = await UploadImage.uploadToStorage(files);

    car.images = urls;

    final response = await http.post(
      Uri.parse(Endpoint.cars),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 422) {
      print(response.body);
      return false;
    } else {
      throw Exception('Gagal menyimpan data: ${response.statusCode}');
    }
  }

  static Future<List<Car>> getCars() async {
    final response = await http.get(Uri.parse(Endpoint.cars));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => Car.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get cars');
    }
  }

  static Future<bool> updateCar(Car car) async {
    print(jsonEncode(car.toJson()));
    final response = await http.put(
      Uri.parse('${Endpoint.cars}/${car.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(car.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }else if(response.statusCode == 422){
      print(response.body);
      return  false;
    }
    else {

      throw Exception('Gagal mengupdate data: ${response.statusCode}');
    }
  }

  static Future<bool> deleteCar(Car car) async {
    final response = await http.delete(Uri.parse("${Endpoint.cars}/${car.id}"));

    if (response.statusCode == 200) {
      return true;
    }
    print(response.body);
    return false;
  }
}
