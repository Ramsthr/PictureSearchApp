import 'package:animalsearchapp/resources/key.dart';
import 'package:flutter/material.dart';
import 'package:pexels_api/pexels_api.dart';
import 'package:pexels_api/src/pexels_search_result.dart';

class GetApi {
  final PexelsClient _client = PexelsClient(ApiKey);

  Future<List<PexelsPhoto>?> getquery(
      String query, int page, BuildContext context) async {
    try {
      SearchResult<PexelsPhoto?>? result = await _client.searchPhotos(query,
          collection: PexelsCollection.Regular, page: page, resultsPerPage: 15);

      List<PexelsPhoto> list = [];
      if (result != null) {
        int length = result.items.length;
        for (int i = 0; i < length; i++) {
          list.add(result[i]!);
        }
      }
      return list;
    } catch (e) {
      return [];
    }
  }

  // getpicture(int index) async {
  //   try {
  //     if (index < _list!.length) {}
  //   } catch (e) {}
  // }
}
