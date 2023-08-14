// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:flutter_firebase/product/constans/color_constants.dart';

class WavyBoldText extends StatelessWidget {
  const WavyBoldText({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        WavyAnimatedText(
          title,
          textStyle: context.general.textTheme.headlineSmall?.copyWith(
            color: ColorConstants.white,
          ),
        ),
      ],
      isRepeatingAnimation: true,
    );
  }
}
