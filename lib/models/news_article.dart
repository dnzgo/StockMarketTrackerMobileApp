/*
  News model for:
  - title
  - description (news summary)
  - imageURL
  - source
  - date
  - articleUrl
*/

class NewsArticle {

  final String title;
  final String description;
  final String imageURL;
  final String source;
  final String date;
  final String articleUrl;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.imageURL,
    required this.source,
    required this.date,
    required this.articleUrl,
  });

}