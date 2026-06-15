/*
  news model for data: title,
  description(article content in short),
  articleText (whole article),
  imageURL (image that related to news),
  source of the news,
  date of the news,
   */
class NewsArticle {

  final String title;
  final String description;
  final String articleText;
  final String imageURL;
  final String source;
  final String date;

  const NewsArticle({
    required this.title,
    required this.description,
    required this.articleText,
    required this.imageURL,
    required this.source,
    required this.date,
  });

}