import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wiki_freo/features/search/models/wiki_page.dart';
import 'package:wiki_freo/pages/wikipedia_page.dart';

///[SearchItem] is used for the each search page in the response
///It has three main elements Title, Image and Description
///Gesture detector onTap will lead to the Wikipedia Webpage Webview
class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.wikiPage});

  final WikiPage wikiPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WikipediaPage(
              title: wikiPage.title,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: 200,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF4A4A4A),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 70,
            height: 100,
            decoration: BoxDecoration(
                color: const Color(0xFF353535),
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                    image: wikiPage.thumbnail != null
                        ? CachedNetworkImageProvider(
                            wikiPage.thumbnail!,
                          )
                        : Image.asset(
                            'assets/images/placeholder.png',
                          ).image,
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 230,
                child: Text(
                  wikiPage.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: 250,
                height: 60,
                child: Text(
                  wikiPage.description ?? '',
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
