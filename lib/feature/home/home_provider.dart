// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_firebase/product/models/news.dart';
import 'package:flutter_firebase/product/models/tag.dart';
import 'package:flutter_firebase/product/utility/firebase/firebase_collections.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> fetchNews() async {
    final newsCollectionReferance = FirebaseCollections.news.referance;

    final response = await newsCollectionReferance.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(news: values);
    }
  }

  Future<void> fetchTags() async {
    final newsCollectionReferance = FirebaseCollections.tag.referance;

    final response = await newsCollectionReferance.withConverter<Tag>(
      fromFirestore: (snapshot, options) {
        return const Tag().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).get();

    if (response.docs.isNotEmpty) {
      final values = response.docs.map((e) => e.data()).toList();
      state = state.copyWith(tags: values);
    }
  }

  Future<void> fecthAndLoad() async {
    state = state.copyWith(isLoading: true);
    await fetchNews();
    await fetchTags();
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.isLoading, this.news, this.tags});

  final List<News>? news;
  final List<Tag>? tags;
  final bool? isLoading;
  @override
  List<Object?> get props => [news, tags, isLoading];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    bool? isLoading,
  }) {
    return HomeState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
