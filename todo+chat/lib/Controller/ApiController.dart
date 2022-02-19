import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class ApiController {
  //static final url = 'http://192.168.1.6:5000/';
  static final url = "https://global-chat-test.herokuapp.com/";

  static Future<bool> addNote(String task) async {
    try {
      print("Adding Note");
      final response = await http.post(Uri.parse(url + 'addnote'),
          body: ({
            'email': FirebaseAuth.instance.currentUser!.email,
            'task': task
          }));
      print(response.body);
      print("Added");
      return true;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<String>> get getNotes async {
    try {
      print("Sending Req");
      final response = await http.get(Uri.parse(
          url + 'getnote?email=${FirebaseAuth.instance.currentUser!.email}'));
      print("Got Response");
      final body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<String> l = [];
        print("Here");
        for (var i in body['data']) {
          l.add(i);
        }
        return l;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw body['message'];
      }
    } catch (error) {
      rethrow;
    }
  }
}
