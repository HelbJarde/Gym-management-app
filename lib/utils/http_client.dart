import 'package:dio/dio.dart';

final Dio httpClient = Dio(
  BaseOptions(
    baseUrl: 'https://retoolapi.dev/',
  ),
);