part of '../home_view.dart';

class _ActiveChip extends StatelessWidget {
  const _ActiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'active',
        style: context.general.textTheme.bodySmall?.copyWith(
          color: ColorConstants.white,
        ),
      ),
      backgroundColor: ColorConstants.purpleDark,
      padding: context.padding.low,
    );
  }
}

class _PassiveChip extends StatelessWidget {
  const _PassiveChip();

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        'active',
        style: context.general.textTheme.bodySmall?.copyWith(
          color: ColorConstants.black,
        ),
      ),
      backgroundColor: ColorConstants.grayPrimary,
      padding: context.padding.low,
    );
  }
}
