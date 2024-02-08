import 'dart:convert';

CategoryDto CategoryDtoFromJson(String str) =>
    CategoryDto.fromJson(json.decode(str));

String CategoryDtoToJson(CategoryDto data) => json.encode(data.toJson());

class CategoryDto {
  int? id;
  String? name;
  String? slug;
  String? image;
  List<SubCategory>? subCategory;
  // int? parentId;
  String? error;

  CategoryDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.subCategory,
    //this.parentId,
  });

  CategoryDto.withError(String errorMessage) {
    error = errorMessage;
  }

  CategoryDto copyWith({
    int? id,
    String? name,
    String? slug,
    String? image,
    List<SubCategory>? subCategory,
    //int? parentId,
  }) {
    return CategoryDto(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      subCategory: subCategory ?? this.subCategory,
      //parentId: parentId ?? this.parentId,
    );
  }

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    if (json['sub_category'] != null) {
      var subCategoriesList = json['sub_category'] as List;
      print(subCategoriesList.runtimeType);
      List<SubCategory> subCategoryList =
          subCategoriesList.map((i) => SubCategory.fromJson(i)).toList();
      return CategoryDto(
        id: json["id"]?.toInt(),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        subCategory: subCategoryList,
        //parentId: json["parentId"],
      );
    } else {
      return CategoryDto(
        id: json["id"]?.toInt(),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        // subCategory: SubCategory.fromJson(json['sub_category']),
        //parentId: json["parentId"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "sub_category": subCategory,
        //"parentId": parentId,
      };

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   if (id != null) {
  //     result.addAll({'id': id});
  //   }
  //   if (name != null) {
  //     result.addAll({'name': name});
  //   }
  //   if (slug != null) {
  //     result.addAll({'slug': slug});
  //   }
  //   if (image != null) {
  //     result.addAll({'image': image});
  //   }
  //   if (subCategory != null) {
  //     result.addAll({'sub_category': subCategory});
  //   }

  //   return result;
  // }

  // factory CategoryDto.fromMap(Map<String, dynamic> map) {
  //   return CategoryDto(
  //     id: map['id']?.toInt(),
  //     name: map['name'],
  //     slug: map['slug'],
  //     image: map['image'],
  //     subCategory: map['sub_category'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory CategoryDto.fromJson(String source) =>
  //     CategoryDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, slug: $slug, image: $image, )';
  }
}

class SubCategory {
  int? id;
  String? name;
  String? slug;
  String? image;
  List? subCategory;

  SubCategory({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.subCategory,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"]?.toInt(),
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        subCategory: json["sub_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "sub_category": subCategory,
      };
}
