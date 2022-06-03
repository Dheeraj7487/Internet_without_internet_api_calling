import 'dart:core';
import 'dart:io';
import 'package:api_internet_without_internet/Helper/database_helper.dart';
import 'package:api_internet_without_internet/Model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Exception/exception.dart';

class ApiManager extends ChangeNotifier {

  final url = 'https://jsonplaceholder.typicode.com/posts';
  List<Model>  postslist = [];
  var showData = [];

  Future getPosts() async {
    try{
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        print("Found Data");
        final data = postsFromJson(response.body);
        postslist = data;
        return postsFromJson(response.body).map((posts) {DatabaseHelper.db.insert(posts);}).toList();
      } else {
        print("Something wrong");
      }
    }
    on SocketException catch (e) {
      final fetchData  = await DatabaseHelper.db.fetchPostsData();
      showData = fetchData;
      // throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException("reegf");
    }
  }

}

