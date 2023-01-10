import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/comments.dart';

class HomeController {
  ValueNotifier<List<Comments>> comments = ValueNotifier<List<Comments>>([]);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  Future getComments() async {
    var client = http.Client();
    try {
      isLoading.value = true;
      var response = await client
          .get(Uri.https("jsonplaceholder.typicode.com", "/comments"));

      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body);

        List<Comments> comments =
            List<Comments>.from(data.map((item) => Comments.fromJson(item)));

        this.comments.value = comments;
      }

      return comments.value;
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
      client.close();
    }
  }
}
