class Photo {
  final int? id;
  final int? albumId;
  final String? url;
  final String? thumbnailUrl;
  final String? title;

  const Photo( this.id, this.albumId, this.url, this.thumbnailUrl,  this.title);

  Photo.fromJson(Map<String, dynamic> jsonObj)
      : this(
    jsonObj["id"],
    jsonObj["albumId"],
    jsonObj["url"],
    jsonObj["thumbnailUrl"],
    jsonObj["title"],
  );
}