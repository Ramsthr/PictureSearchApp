import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';
import 'package:pexels_api/src/pexels_search_result.dart';

class GetApi extends ChangeNotifier {
  var client =
      PexelsClient('zI0i1nmABFRPRGCvXIQ8q0JN3bBVraVD5xeuZ8pSRwYetOdNIF3JGmVV');
  List<PexelsPhoto>? _list = [];
  List<PexelsPhoto>? get list => _list;

  getquery(String query, int page) async {
    try {
      SearchResult<PexelsPhoto?>? result = await client.searchPhotos(query,
          collection: PexelsCollection.Regular, page: page, resultsPerPage: 15);

      if (result != null) {
        for (int i = 0; i < 15; i++) {
          _list!.add(result[i]!);
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
