import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/product/models/news.dart';
import 'package:flutter_firebase/product/utility/exception/exception.dart';
import 'package:flutter_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:kartal/kartal.dart';

class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  @override
  Widget build(BuildContext context) {
    final news = FirebaseCollections.news.reference;
    final response = news.withConverter(
      fromFirestore: (snapshot, options) {
        return const News().fromFirebase(snapshot);
      },
      toFirestore: (value, options) {
        // ignore: unnecessary_null_comparison
        if (value == null) throw FirebaseCustomException('$value not null');
        return value.toJson();
      },
    ).get();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: response,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<News>> snapshot,
        ) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('none');
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return const Text('active');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                final values =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: [
                          // Image.network(
                          //   values[index].backgroundImage ?? '',
                          //   height: context.sized.dynamicHeight(0.1),
                          // ),
                          Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/flutter-full-eadb7.appspot.com/o/beyaz_saray.jpeg?alt=media&token=53270cfe-b6eb-43b2-aea1-220faa053897',
                          ),
                          Text(
                            values[index].title ?? '',
                            style: context.general.textTheme.labelLarge,
                          ),
                          Text(values[index].category ?? ''),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Text('done');
          }
        },
      ),
    );
  }
}
