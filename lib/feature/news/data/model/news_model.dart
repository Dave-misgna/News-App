class NewsModel {
  final String sectionName;
  final String title;
  final String thumbnail;
  final String publicationDate;

  NewsModel({
    required this.sectionName,
    required this.title,
    required this.thumbnail,
    required this.publicationDate,
  });

  factory NewsModel.fromJson(Map<String,dynamic> json) {
    return NewsModel(
      sectionName: json['sectionName'] ?? '',
      title: json['webTitle'] ?? '',
      thumbnail: json['fields'] != null ? json['fields']['thumbnail'] ?? '' : '',
      publicationDate: json['webPublicationDate'] ?? '',
    );
  }
}
