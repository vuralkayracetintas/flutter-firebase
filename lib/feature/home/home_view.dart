// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_firebase/product/models/news.dart';
// import 'package:flutter_firebase/product/utility/exception/exception.dart';
// import 'package:kartal/kartal.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference news =
//         FirebaseFirestore.instance.collection('news');

//     final response = news.withConverter(
//       fromFirestore: (snapshot, options) {
//         return const News().fromFirebase(snapshot);
//       },
//       toFirestore: (value, options) {
//         // ignore: unnecessary_null_comparison
//         if (value == null) throw FirebaseCustomException('$value not null');
//         return value.toJson();
//       },
//     ).get();

//     return Scaffold(
//       appBar: AppBar(),
//       body: FutureBuilder(
//         future: response,
//         builder: (
//           BuildContext context,
//           AsyncSnapshot<QuerySnapshot<News>> snapshot,
//         ) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return const Text('none');
//             case ConnectionState.waiting:
//               return const CircularProgressIndicator();
//             case ConnectionState.active:
//               return const Text('active');
//             case ConnectionState.done:
//               if (snapshot.hasError) {
//                 return Text(snapshot.error.toString());
//               }
//               if (snapshot.hasData) {
//                 final values =
//                     snapshot.data!.docs.map((e) => e.data()).toList();
//                 return ListView.builder(
//                   itemCount: values.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Card(
//                       child: Column(
//                         children: [
//                           // Image.network(
//                           //   values[index].backgroundImage ?? '',
//                           //   height: context.sized.dynamicHeight(0.1),
//                           // ),
//                           Image.network(
//                             'https://firebasestorage.googleapis.com/v0/b/flutter-full-eadb7.appspot.com/o/beyaz_saray.jpeg?alt=media&token=53270cfe-b6eb-43b2-aea1-220faa053897',
//                           ),
//                           Text(
//                             values[index].title ?? '',
//                             style: context.general.textTheme.labelLarge,
//                           ),
//                           Text(values[index].category ?? ''),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               }
//               return const Text('done');
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_firebase/product/constans/index.dart';
import 'package:flutter_firebase/product/enums/index.dart';
import 'package:flutter_firebase/product/widgets/text/subtitle_text.dart';
import 'package:flutter_firebase/product/widgets/text/title_text.dart';
import 'package:kartal/kartal.dart';

part 'sub_view/home_chip.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ListView(
          padding: context.padding.low,
          children: const [
            _Header(),
            _CustomField(),
            _TagListView(),
            _BrowseHorizontalListView(),
            _RecommendedHeader(),
            _RecommendedListView()
          ],
        ),
      ),
    );
  }
}

class _CustomField extends StatelessWidget {
  const _CustomField();

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.mic_outlined),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: ColorConstants.grayLight,
        hintText: StringConstants.search,
      ),
    );
  }
}

class _RecommendedListView extends StatelessWidget {
  const _RecommendedListView();

  static const cmImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-full-eadb7.appspot.com/o/lpc.jpeg?alt=media&token=5f815b54-e635-41b4-895d-1f7f3ec0328a';

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return const _RecommendedCard(cmImage: cmImage);
      },
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
    required this.cmImage,
  });

  final String cmImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.padding.onlyTopLow,
      child: Row(
        children: [
          Image.network(
            _RecommendedListView.cmImage,
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
            height: 96,
          ),
          const Expanded(
            child: ListTile(
              title: Text(
                'Computer Science',
              ),
              subtitle: Text(
                'I learn Flutter and Dart',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedHeader extends StatelessWidget {
  const _RecommendedHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: TitleText(
            value: StringConstants.recommended,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(StringConstants.seeAll),
        )
      ],
    );
  }
}

class _BrowseHorizontalListView extends StatelessWidget {
  const _BrowseHorizontalListView();

  static const palaceImage =
      'https://firebasestorage.googleapis.com/v0/b/flutter-full-eadb7.appspot.com/o/beyaz_saray.jpeg?alt=media&token=53270cfe-b6eb-43b2-aea1-220faa053897';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return const _HorizontalCard(palaceImage: palaceImage);
        },
      ),
    );
  }
}

class _HorizontalCard extends StatelessWidget {
  const _HorizontalCard({
    required this.palaceImage,
  });

  final String palaceImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: context.padding.onlyRightNormal,
          child: Image.network(
            _BrowseHorizontalListView.palaceImage,
            errorBuilder: (context, error, stackTrace) => const Placeholder(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: context.padding.low,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    size: WidgetSize.iconNormal.value,
                    color: ColorConstants.white,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: context.padding.low,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SubTitleText(
                        value: 'Beyaz Saray',
                        color: ColorConstants.black,
                      ),
                      Text(
                        'The latest situation in the presidential election',
                        style:
                            context.general.textTheme.headlineSmall?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _TagListView extends StatelessWidget {
  const _TagListView();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(0.1),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) {
            return const _ActiveChip();
          }

          return const _PassiveChip();
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          value: StringConstants.homeTitle,
        ),
        SubTitleText(value: StringConstants.homeSubtitle),
      ],
    );
  }
}
