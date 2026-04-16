import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Map<String, String> get _headers => {
        'Authorization': 'Token ${AppConstants.apiToken}',
        'Content-Type': 'application/json',
      };

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(AppConstants.apiBaseUrl + endpoint).replace(
      queryParameters: queryParams,
    );

    final response = await _client.get(uri, headers: _headers);

    if (response.statusCode != 200) {
      throw ApiException(
        'Erro ao buscar dados: ${response.reasonPhrase}',
        statusCode: response.statusCode,
      );
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  void dispose() => _client.close();
}
