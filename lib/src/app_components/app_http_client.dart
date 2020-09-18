/*
 * File: AppHttpClient.dart
 * Project: CVideo
 * File Created: Saturday, 13th June 2020 11:02 am
 * Author: luonglv39 (luonglvse130702@fpt.edu.vn)
 * -----
 * Last Modified: Saturday, 13th June 2020 11:49 am
 * Modified By: luonglv39 (luonglvse130702@fpt.edu.vn>)
 * -----
 * Copyright (c) Daxua Team
 */
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class AppHttpClient {
  /// Base url for entire the app
  // static final String baseUrl = "https://cvideo-api-host.azurewebsites.net/api/v1";
  static final String baseUrl = "https://10.0.2.2:5001/api/v1";

  /// Sends an HTTP GET request with the given headers to the given URL.
  static Future<http.Response> get(String url, {Map<String, String> headers}) =>
      http.get('$baseUrl$url', headers: headers);

  /// Sends an HTTP POST request with the given headers and body to the given URL.
  static Future<http.Response> post(url,
          {Map<String, String> headers, body, Encoding encoding}) =>
      http.post('$baseUrl$url',
          headers: headers, body: body, encoding: encoding);

  /// Sends an HTTP PUT request with the given headers and body to the given URL.
  static Future<http.Response> put(url,
          {Map<String, String> headers, body, Encoding encoding}) =>
      http.put('$baseUrl$url',
          headers: headers, body: body, encoding: encoding);

  /// Sends an HTTP DELETE request with the given headers to the given URL.
  static Future<http.Response> delete(url, {Map<String, String> headers}) =>
      http.delete('$baseUrl$url', headers: headers);

  // TO-DO
  static Future<http.Response> postTest(
    url, {
    Map<String, String> headers,
    body,
    Encoding encoding,
  }) {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    IOClient ioClient = new IOClient(client);

    return ioClient.post(
      "$baseUrl$url",
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}
