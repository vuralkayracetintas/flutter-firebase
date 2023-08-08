// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_firebase/product/enums/cache_items.dart';
import 'package:flutter_firebase/product/initialize/app_cache.dart';

class AuthenticationNotifier extends StateNotifier<AuthenticationState> {
  AuthenticationNotifier() : super(AuthenticationState());

  Future<void> fetchUserDetails(User user) async {
    final token = await user.getIdToken();
    await tokenSaveToCache(token!);
    state = state.copyWith(isRedirect: true);
  }

  Future<void> tokenSaveToCache(String token) async {
    await CacheItems.token.write(token);
  }
}

class AuthenticationState extends Equatable {
  AuthenticationState({this.isRedirect = false});

  final bool isRedirect;

  @override
  // TODO: implement props
  List<Object> get props => [isRedirect];

  AuthenticationState copyWith({
    bool? isRedirect,
  }) {
    return AuthenticationState(
      isRedirect: isRedirect ?? this.isRedirect,
    );
  }
}
