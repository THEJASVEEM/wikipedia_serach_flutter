import 'dart:developer';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' show Client;
import 'package:wiki_freo/features/search/models/wiki.dart';

class WikiSearchService {
  static Client client = Client();

  static Future<Wiki> fetchPages(String query, num offset) async {
    try {
      final responseCache = await DefaultCacheManager().getSingleFile(
          'https://en.wikipedia.org/w/api.php?action=query&format=json&generator=prefixsearch&gpssearch=$query&gpslimit=10&gpsoffset=$offset&prop=pageimages%7Cpageterms&piprop=thumbnail&pithumbsize=50&pilimit=10&redirects=&wbptterms=description');
      final jsonData = await responseCache.readAsString();
      return Wiki.fromJson(jsonData);
    } catch (e) {
      log(e.toString());
      throw Exception('Service request error');
    }
  }
}
