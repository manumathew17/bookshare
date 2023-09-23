class Book {
  final int id;
  final String title;
  final String bookRefId;
  final String etag;
  final String description;
  final String isbn;
  final String price;
  final Images images;
  final int categoryId;
  final int authorId;
  final int attributeId;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final String author;
  final String category;
  final String publisher;
  final String publicationDate;
  final int edition;
  final String genre;
  final int pageCount;
  final String bindingType;
  final String language;
  final String dimensions;
  final String keywords;
  final String reviews;
  final String ratings;

  Book({
    required this.id,
    required this.title,
    required this.bookRefId,
    required this.etag,
    required this.description,
    required this.isbn,
    required this.price,
    required this.images,
    required this.categoryId,
    required this.authorId,
    required this.attributeId,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.author,
    required this.category,
    required this.publisher,
    required this.publicationDate,
    required this.edition,
    required this.genre,
    required this.pageCount,
    required this.bindingType,
    required this.language,
    required this.dimensions,
    required this.keywords,
    required this.reviews,
    required this.ratings,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      bookRefId: json['book_ref_id'] ?? '',
      etag: json['etag'] ?? '',
      description: json['description'] ?? '',
      isbn: json['isbn'] ?? '',
      price: json['price'] ?? '',
      images: Images.fromJson(json['images'] ?? {}),
      categoryId: json['category_id'] ?? 0,
      authorId: json['author_id'] ?? 0,
      attributeId: json['attribute_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      deletedAt: json['deleted_at'] ?? '',
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      publisher: json['publisher'] ?? '',
      publicationDate: json['publication_date'] ?? '',
      edition: json['edition'] ?? 0,
      genre: json['genre'] ?? '',
      pageCount: json['page_count'] ?? 0,
      bindingType: json['binding_type'] ?? '',
      language: json['language'] ?? '',
      dimensions: json['dimensions'] ?? '',
      keywords: json['keywords'] ?? '',
      reviews: json['reviews'] ?? '',
      ratings: json['ratings'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'book_ref_id': bookRefId,
      'etag': etag,
      'description': description,
      'isbn': isbn,
      'price': price,
      'images': images.toJson(),
      'category_id': categoryId,
      'author_id': authorId,
      'attribute_id': attributeId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'author': author,
      'category': category,
      'publisher': publisher,
      'publication_date': publicationDate,
      'edition': edition,
      'genre': genre,
      'page_count': pageCount,
      'binding_type': bindingType,
      'language': language,
      'dimensions': dimensions,
      'keywords': keywords,
      'reviews': reviews,
      'ratings': ratings,
    };
  }
}

class Images {
  final String smallThumbnail;
  final String thumbnail;

  Images({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      smallThumbnail: json['smallThumbnail'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'smallThumbnail': smallThumbnail,
      'thumbnail': thumbnail,
    };
  }
}
