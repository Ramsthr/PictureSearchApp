import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';
import 'package:pexels_api/src/pexels_search_result.dart';

class ApiFetch with ChangeNotifier {
  var client =
      PexelsClient('zI0i1nmABFRPRGCvXIQ8q0JN3bBVraVD5xeuZ8pSRwYetOdNIF3JGmVV');

  late List<PexelsPhoto> _list;

  List<PexelsPhoto> get list => _list;

  Future<String?> get() async {
    try {
      PexelsPhoto? photo = await client.getPhoto();
      if (photo != null) {
        String? str = photo.get(ImageFormats.original);
        return str;
      }
    } catch (e) {
      return "";
    }
  }

  Future<List<String>?> getquery(String query, int page) async {
    SearchResult<PexelsPhoto?>? result = await client.searchPhotos(query,
        collection: PexelsCollection.Regular, page: page, resultsPerPage: 15);
    List<String>? ls = [];
    if (result != null) {
      for (int i = 0; i < 15; i++) {
        ls.add(result[i]!.get(ImageFormats.small)!);
      }
    }
    return ls;
  }
}
