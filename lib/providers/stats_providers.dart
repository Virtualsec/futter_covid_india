import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/data_modal.dart';

class StatsProviders with ChangeNotifier {
  List<Data> _stats = [];

  var dio = Dio();
  var baseUrl = 'https://api.covid19india.org';

  get getData {
    return [..._stats];
  }

  fetchData() async {
    var url = '$baseUrl/data.json';
    log('Fetching Data.....');
    log('$url');
    try {
      var response = await dio.get(url);
      List<Data> resData = (response.data['statewise'] as List)
          .map((json) => Data.fromJson(json))
          .toList();
      log('${resData[0]}');
      _stats = resData;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
