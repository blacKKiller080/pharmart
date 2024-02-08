import 'dart:convert';

class Product {
  final int? id;
  final String? name;
  final int? articul;
  final String? description;
  final String? image;
  final String? linkToVideo;
  final String? slug;
  final int? manufacturerId;
  final int? categoryId;

  Product({
    this.id,
    this.name,
    this.description,
    this.image,
    this.linkToVideo,
    this.articul,
    this.slug,
    this.manufacturerId,
    this.categoryId,
  });

  Product copyWith({
    int? id,
    String? name,
    int? articul,
    String? description,
    String? image,
    String? linkToVideo,
    String? slug,
    int? manufacturerId,
    int? categoryId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      linkToVideo: linkToVideo ?? this.linkToVideo,
      articul: articul ?? this.articul,
      slug: slug ?? this.slug,
      categoryId: categoryId ?? this.categoryId,
      manufacturerId: manufacturerId ?? this.manufacturerId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (linkToVideo != null) {
      result.addAll({'link_to_video': linkToVideo});
    }
    if (articul != null) {
      result.addAll({'articul': articul});
    }
    if (slug != null) {
      result.addAll({'slug': slug});
    }
    if (categoryId != null) {
      result.addAll({'categoryId': categoryId});
    }
    if (manufacturerId != null) {
      result.addAll({'manufacturerId': manufacturerId});
    }

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt(),
      name: map['name'],
      description: map['description'],
      image: map['image'],
      linkToVideo: map['link_to_video'],
      articul: map['articul'],
      slug: map['slug'],
      categoryId: map['categoryId'],
      manufacturerId: map['manufacturerId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, description: $description, image: $image, link_to_video: $linkToVideo, articul: $articul, slug: $slug, categoryId: $categoryId, manufacturerId: $manufacturerId )';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.linkToVideo == linkToVideo &&
        other.articul == articul &&
        other.slug == slug &&
        other.categoryId == categoryId &&
        other.manufacturerId == manufacturerId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        linkToVideo.hashCode ^
        slug.hashCode ^
        articul.hashCode ^
        categoryId.hashCode ^
        manufacturerId.hashCode;
  }
}

// @freezed
// class Product with _$Product {
//   const factory Product(
//       {final String? id,
//       final String? name,
//       final double? price,
//       final String? image,
//       final String? formatProduct,
//       final String? origin,
//       final String? areaOfUse,
//       final String? type,
//       final int? articul}) = _Product;

//   factory Product.fromJson(Map<String, Object?> json) =>
//       _$ProductFromJson(json);
// }
