import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../error/api_exception.dart';

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$baseUrl$path');

    try {
      final response = await _client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      if (response.statusCode >= 400) {
        String message = 'Ошибка сервера';
        try {
          final json = jsonDecode(response.body);
          message = json['message'] ?? message;
        } catch (_) {}
        throw ApiException(message, statusCode: response.statusCode);
      }

      throw ApiException('Неизвестная ошибка');
    } on SocketException {
      throw ApiException('Нет подключения к интернету');
    } on TimeoutException {
      throw ApiException('Превышено время ожидания (10 секунд)');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Произошла непредвиденная ошибка');
    }
  }
}
