import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smride_app/data/response/app_exceptions.dart';
import 'package:smride_app/data/network/baseApiServices.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApiResponse(url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiResponse(url, data) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: data);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future patchApiResponse(url, data) async {
    dynamic responseJson;
    try {
      final response = await http.patch(Uri.parse(url), body: data);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future deleteApiResponse(url) async {
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future putApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        throw AppExceptions("Internal Server Error", "Error: ");
      default:
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return jsonDecode(response.body);
        } else if (response.statusCode >= 400 && response.statusCode < 500) {
          throw BadRequestException(jsonDecode(response.body)['error']);
        } else {
          throw FetchDataException(
              "Error occured while communication with server ${response.statusCode}");
        }
    }
  }
}
