// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase/product/models/news.dart';
import 'package:flutter_firebase/product/models/recommended.dart';
import 'package:flutter_firebase/product/models/tag.dart';
import 'package:flutter_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_firebase/product/utility/firebase/firebase_utility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNotifier extends StateNotifier<HomeState> with FirebaseUtility {
  HomeNotifier() : super(const HomeState());

  List<Tag> _fullTagList = [];
  List<Tag> get fullTagList => _fullTagList;

  Future<void> fetchNews() async {
    // final items = fetchList<News, News>(const News(), FirebaseCollections.news);
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
    // final items =
    //     await fetchList<Tag, Tag>(const Tag(), FirebaseCollections.tag);
    // state = state.copyWith(tags: items);

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

    _fullTagList = state.tags ?? [];
  }

  Future<void> fetchRecommended() async {
    final items = await fetchList<Recommended, Recommended>(
      const Recommended(),
      FirebaseCollections.recommended,
    );
    state = state.copyWith(recommended: items);
  }

  Future<void> fecthAndLoad() async {
    state = state.copyWith(isLoading: true);

    await Future.wait([fetchNews(), fetchTags(), fetchRecommended()]);
    state = state.copyWith(isLoading: false);
  }
}

class HomeState extends Equatable {
  const HomeState({this.isLoading, this.news, this.tags, this.recommended});

  final List<News>? news;
  final List<Tag>? tags;
  final bool? isLoading;
  final List<Recommended>? recommended;
  @override
  List<Object?> get props => [news, tags, isLoading, recommended];

  HomeState copyWith({
    List<News>? news,
    List<Tag>? tags,
    bool? isLoading,
    List<Recommended>? recommended,
  }) {
    return HomeState(
      news: news ?? this.news,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      recommended: recommended ?? this.recommended,
    );
  }
}
