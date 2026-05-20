import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../exceptions/app_exceptions.dart';

abstract class IHttpClient {
  Future<Map<String, dynamic>> get({
    required String url,
    required Map<String, String> headers,
  });

  Future<Map<String, dynamic>> post({
    required dynamic body,
    required String url,
    required Map<String, String> headers,
  });

  Future<Map<String, dynamic>> patch({
    required dynamic body,
    required String url,
    required Map<String, String> headers,
  });

  Future<Map<String, dynamic>> delete({
    required String url,
    required Map<String, String> headers,
    String? body,
  });
}

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<Map<String, dynamic>> get({
    required String url,
    required Map<String, String> headers,
  }) async {
    log("HTTP CLIENT GET");
    log(url);

    try {
      final response = await client
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));

      // log(headers.toString());
      // log(response.statusCode.toString());
      // log(response.body);

      return _handleResponse(response);
    } on SocketException catch (e) {
      log("Erro de conexão: $e");
      throw ServerConnectionException();
    } on TimeoutException catch (e) {
      log("Tempo esgotado: $e");
      throw ServerTimeoutException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post({
    required body,
    required String url,
    Map<String, String>? headers,
  }) async {
    log("HTTP CLIENT POST");
    log(url);

    try {
      var response = await client
          .post(
            Uri.parse(url),
            headers: headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(const Duration(seconds: 10));

      // log(body.toString());
      // log("HEADERS");
      // log(headers.toString());
      log(response.statusCode.toString());
      log(response.body);

      return _handleResponse(response);
    } on SocketException catch (e) {
      log("Erro de conexão: $e");
      throw ServerConnectionException();
    } on TimeoutException catch (e) {
      log("Tempo esgotado: $e");
      throw ServerTimeoutException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> patch({
    required body,
    required String url,
    Map<String, String>? headers,
  }) async {
    log("HTTP CLIENT PATCH");
    log(url);

    try {
      var response = await client
          .patch(
            Uri.parse(url),
            headers: headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(const Duration(seconds: 10));

      log(response.statusCode.toString());
      log(response.body);

      return _handleResponse(response);
    } on SocketException catch (e) {
      log("Erro de conexão: $e");
      throw ServerConnectionException();
    } on TimeoutException catch (e) {
      log("Tempo esgotado: $e");
      throw ServerTimeoutException();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> delete({
    required String url,
    required Map<String, String> headers,
    String? body,
  }) async {
    log("HTTP CLIENT DELETE");
    log(url);

    try {
      var response = await client
          .delete(
            Uri.parse(url),
            headers: headers,
            body: body != null ? json.encode(body) : null,
          )
          .timeout(const Duration(seconds: 10));

      log(response.statusCode.toString());
      log(response.body);

      return _handleResponse(response);
    } on SocketException catch (e) {
      log("Erro de conexão: $e");
      throw ServerConnectionException();
    } on TimeoutException catch (e) {
      log("Tempo esgotado: $e");
      throw ServerTimeoutException();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final int statusCode = response.statusCode;
    final String body = response.body;

    // If Error, throws
    if (statusCode == 401) {
      throw UnauthorizedException();
    }

    // If success, check if return is a List
    if (statusCode == 200 || statusCode == 201) {
      //  If success but response is empty, return empty map
      if (body.trim().isEmpty) {
        log("EMPTY RETURN");
        return {};
      }

      var currentBody = jsonDecode(body);

      //log("is a List");
      if (currentBody is List) {
        return {'results': currentBody};
      }
      //log("is not a List");
      return currentBody;
    }

    // If is not 401 and is not success, then it's a different error
    Map<String, dynamic> bodyData = {};
    if (body.isNotEmpty) bodyData = jsonDecode(body);
    throw HttpException(bodyData['message'] ?? "Unknown HTTP Error");
  }
}
