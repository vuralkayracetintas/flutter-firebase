import 'package:equatable/equatable.dart';
import 'package:flutter_firebase/product/utility/base/base_firebase_model.dart';

class News extends Equatable with IdModel, BaseFirebaseModel<News> {
  const News({
    this.category,
    this.categoryId,
    this.title,
    this.backGroundImage,
    this.id,
  });

  final String? category;
  final String? categoryId;
  final String? title;
  final String? backGroundImage;
  @override
  final String? id;

  @override
  List<Object?> get props => [category, categoryId, title, backGroundImage, id];

  News copyWith({
    String? category,
    String? categoryId,
    String? title,
    String? backGroundImage,
    String? id,
  }) {
    return News(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      backGroundImage: backGroundImage ?? this.backGroundImage,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': categoryId,
      'title': title,
      'backGroundImage': backGroundImage,
      'id': id,
    };
  }

  @override
  News fromJson(Map<String, dynamic> json) {
    return News(
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      title: json['title'] as String?,
      backGroundImage: json['backGroundImage'] as String?,
      id: json['id'] as String?,
    );
  }
}
