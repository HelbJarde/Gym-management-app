import 'package:flutter/material.dart';
import 'package:gym_management/models/user1.dart';
import 'package:gym_management/utils/http_client.dart';

class UserService {
  static ValueNotifier<List<User1>> usersList = ValueNotifier([]);
  
  static Future<List<User1>> getUsers() async {
    var response = await httpClient.get('dY4Ilx/Gym');
    if (response.statusCode == 200 || response.statusCode == 201) {
      usersList.value = [];
      for (var element in response.data) {
        usersList.value.add(User1.fromJson(element));
      }
      return usersList.value;
    }
    throw Exception('Error');
  }

  static Future<List<User1>> getUsersByFullName(String fullName) async {
    var response = await httpClient.get('dY4Ilx/Gym?FullName=$fullName');
    if (response.statusCode == 200 || response.statusCode == 201) {
      usersList.value = [];
      for (var element in response.data) {
        usersList.value.add(User1.fromJson(element));
      }
      return usersList.value;
    }
    throw Exception('Error');
  }

  static Future<User1> addUser(User1 user) async {
    var response = await httpClient.post('dY4Ilx/Gym', data: user.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      await getUsers();
      return User1.fromJson(response.data);
    }
    throw Exception('Error');
  }

  static Future<User1> updateUser(
      {required User1 user, required int userId}) async {
    var response =
        await httpClient.put('dY4Ilx/Gym/$userId', data: user.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      await getUsers();
      return User1.fromJson(response.data);
    }
    throw Exception('Error');
  }

  static Future<User1> deleteUser(int userId) async {
    var response = await httpClient.delete('dY4Ilx/Gym/$userId');
    if (response.statusCode == 200 || response.statusCode == 201) {
      await getUsers();
      return User1.fromJson(response.data);
    }
    throw Exception('Error');
  }
}
