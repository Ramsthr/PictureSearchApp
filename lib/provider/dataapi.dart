import 'package:animalsearchapp/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';

class ApiFetch with ChangeNotifier {
  List<PexelsPhoto>? _list = [];

  List<PexelsPhoto>? get list => _list;

  int _page = 1;
  String _query = "";
  static bool isbool = false;

  static setbool(bool isbool1) {
    isbool = isbool1;
  }

  final GetApi api = GetApi();

  getPexelList(String query) async {
    if (query != _query) {
      _query = query;
      _page = 1;
    }
    if (isbool) {
      List<PexelsPhoto>? list1 = await api.getquery(_query, _page);
      _list!.addAll(list1!);
    } else {
      _list = await api.getquery(_query, _page);
    }
    _page++;
    notifyListeners();
  }
}
