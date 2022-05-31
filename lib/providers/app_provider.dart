import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/data_model.dart';
import 'package:flutter_challenge/utils/api_connect.dart';

export 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    getData();
  }

  final _api = ApiProvider.instance;

  DataModel? data;

  Future<void> getData() async {
    data = await _api.getData();
    notifyListeners();
  }
}
