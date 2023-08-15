import 'package:flutter/material.dart';
import 'package:flutter_firebase/feature/home/home_provider.dart';
import 'package:flutter_firebase/feature/home/sub_view/home_news_list_view.dart';
import 'package:flutter_firebase/product/constans/index.dart';
import 'package:flutter_firebase/product/enums/index.dart';
import 'package:flutter_firebase/product/widgets/card/home_news_card.dart';
import 'package:flutter_firebase/product/widgets/text/subtitle_text.dart';
import 'package:flutter_firebase/product/widgets/text/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
part 'sub_view/home_chip.dart';

final _homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref.read(_homeProvider.notifier).fecthAndLoad();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: context.padding.low,
              children: const [
                _Header(),
                _CustomField(),
                _TagListView(),
                _BrowseHorizontalListView(),
                _RecommendedHeader(),
                _RecommendedListView(),
                // HomeListView()
              ],
            ),
            if (ref.watch(_homeProvider).isLoading ?? false)
              const Center(
                child: CircularProgressIndicator(),
              )
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

class _BrowseHorizontalListView extends ConsumerWidget {
  const _BrowseHorizontalListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsItem = ref.watch(_homeProvider).news ?? [];
    return SizedBox(
      height: context.sized.dynamicHeight(0.3),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItem.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeNewsCard(newsItem: newsItem[index]);
        },
      ),
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
