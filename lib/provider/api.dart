import 'package:pexels_api/pexels_api.dart';
import 'package:pexels_api/src/pexels_search_result.dart';

class GetApi {
  final PexelsClient _client =
      PexelsClient('zI0i1nmABFRPRGCvXIQ8q0JN3bBVraVD5xeuZ8pSRwYetOdNIF3JGmVV');

  Future<List<PexelsPhoto>?> getquery(String query, int page) async {
    try {
      SearchResult<PexelsPhoto?>? result = await _client.searchPhotos(query,
          collection: PexelsCollection.Regular, page: page, resultsPerPage: 15);
      List<PexelsPhoto> list = [];
      if (result != null) {
        for (int i = 0; i < 15; i++) {
          list.add(result[i]!);
        }
      }
      return list;
    } catch (e) {
      print(e);
      return [];
    }
  }

  // getpicture(int index) async {
  //   try {
  //     if (index < _list!.length) {}
  //   } catch (e) {}
  // }
}
