import 'dart:convert';
import 'package:http/http.dart' as Http;
import '../services/LoggerService.dart';
import '../models/DogModel.dart';

 
class DogService {
  static Future<DogModel> randomDog() async {
    var url = "https://dog.ceo/api/breeds/image/random";
    var response = await Http.get(url);
    Map map = json.decode(response.body);
    DogModel msg = DogModel.fromJson(map);
    logger.i("URL image = " + msg?.message);
    return msg;
  }
}