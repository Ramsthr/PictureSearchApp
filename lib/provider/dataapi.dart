import 'package:animalsearchapp/resources/api.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';

class ApiFetch with ChangeNotifier {
  List<PexelsPhoto>? _list = [];

  List<PexelsPhoto>? get list => _list;

  int _page = 1;
  String _query = "";

  final GetApi api = GetApi();

  getPexelList(String query, BuildContext context) async {
    if (query != _query) {
      _query = query;
      _page = 1;
      _list = await api.getquery(_query, _page, context);
      _page++;
      if (_list == []) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 10),
          content: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Data is not avialable",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            ),
          ),
        ));
      }
      notifyListeners();
    }
  }

  getPexellistbyScoll(BuildContext context) async {
    List<PexelsPhoto>? list1 = await api.getquery(_query, _page, context);

    if (list1 != null) {
      if (list1.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 10),
          content: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                "Data is not avialable",
                style: TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w700,
                    color: Colors.red),
              ),
            ),
          ),
        ));
      }
      _list!.addAll(list1);
    }
    _page++;
    notifyListeners();
  }
}
