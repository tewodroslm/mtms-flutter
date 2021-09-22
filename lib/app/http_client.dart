import 'package:dio/dio.dart';

// ignore: non_constant_identifier_names
// final String API_BASE_URL = 'http://192.168.1.7';

// ignore: non_constant_identifier_names
// const String API_BASE_URL = 'https://damp-coast-22655.herokuapp.com';
const String API_BASE_URL = 'http://127.0.0.1:8000';

/// Dio HTTP client, accessible globally with a single [API_BASE_URL]
///
/// @return [Dio]
final Dio dio = Dio(
  BaseOptions(
    baseUrl: API_BASE_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ),
);
