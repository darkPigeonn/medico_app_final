class ModelResources1 {
  String title = "",
      content = "",
      excerpt = "",
      publishDate = "",
      author = "",
      slug = "",
      imageLink = "";

  ModelResources1(
      {required this.title,
      required this.content,
      required this.excerpt,
      required this.publishDate,
      required this.author,
      required this.slug,
      required this.imageLink});

  factory ModelResources1.fromJson(Map<String, dynamic> json) {
    String imageUrl = 'kosong';
    final imageLinkApi = json['imageLink'];

    if (!imageLinkApi.toString().isEmpty) {
      imageUrl = json['imageLink'];
    }

    return new ModelResources1(
        title: json['title'],
        content: json['content'],
        excerpt: json['excerpt'],
        publishDate: json['publishDate'],
        author: json['author'],
        slug: json['slug'],
        imageLink: imageUrl);
  }
}
