import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> postRequest () async {

  var url ='url';

  Map data = {
    'name': 'value'
  };

  var body = json.encode(data);

  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );
  print("${response.statusCode}");
  print("${response.body}");

  return response;
}

Future<http.Response> getRequest () async {
  
  var url ='url';

  var response = await http.get(url,
      headers: {"Content-Type": "application/json"},
  );

  print("${response.statusCode}");
  print("${response.body}");

  return response;
}