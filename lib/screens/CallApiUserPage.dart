import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/LoggerService.dart';
import '../models/UserModel.dart';
import 'package:http/http.dart' as myHttp;


class CallApiUserPage extends StatefulWidget {
  @override
  _CallApiUserPageState createState() => _CallApiUserPageState();
}

class _CallApiUserPageState extends State<CallApiUserPage> {
  var isLoading = false;
  List<UserModel> list = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON: USER"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: new Text("Fetch Data"),
            onPressed: fetchUser,
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(list[index].title),
                    trailing: new Image.network(
                      list[index].image,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }));
  }


//=================================================================================
// FUNCTION GET USER
//=================================================================================
Future<List<UserModel>> fetchUser() async {
  setState(() {
    isLoading = true;
  });
  final response = await myHttp.get('https://jsonplaceholder.typicode.com/photos');
  String logResponse = response.statusCode.toString();
  if (response.statusCode == 200) {
    logger.i('ResponseStatusCode: $logResponse'); // Check Status Code = 200
    logger.i('ResponseBody: ' + response.body); // Read Data in Array
    List<dynamic> responseJson = json.decode(response.body);
    isLoading = false;
    return responseJson.map((m) => new UserModel.fromJson(m)).toList();
  } else {
    throw Exception('error :(');
  }
}

}