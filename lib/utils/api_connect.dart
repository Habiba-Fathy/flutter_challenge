import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_challenge/models/data_model.dart';
import 'package:flutter_challenge/utils/vars.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiProvider {
  ApiProvider._() {
    if (kDebugMode) _dio.interceptors.add(_logger);
  }

  static final ApiProvider instance = ApiProvider._();

// Http Client
  final Dio _dio = Dio();

// Logger
  final PrettyDioLogger _logger = PrettyDioLogger(
    requestBody: true,
    responseBody: true,
    error: true,
    requestHeader: true,
  );

// Headers
  final Map<String, dynamic> _apiHeaders = <String, dynamic>{
    'Accept': 'application/json',
  };

///////////////////////////////////////////////////////////////////
  Future<DataModel> getData() async {
    final response = await _dio.get(
      Connection.url,
      options: Options(
        headers: {
          ..._apiHeaders,
        },
      ),
    );
    if (_validResponse(response.statusCode!)) {
      return DataModel.fromMap(response.data);
    } else {
      throw response.data;
    }
  }
}

////////////////////////////////// UTILS ///////////////////////////////////////
// Validating Request.
bool _validResponse(int statusCode) => statusCode >= 200 && statusCode < 300;
