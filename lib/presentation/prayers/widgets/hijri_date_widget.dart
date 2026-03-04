part of '../prayers.dart';

class HijriDateWidget extends StatelessWidget {
  final Color? svgColor;
  final Color? fontColor;
  final double? horizontalPadding;
  final AlignmentGeometry? alignment;
  const HijriDateWidget(
      {super.key,
      this.svgColor,
      this.fontColor,
      this.horizontalPadding,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${EventController.instance.hijriNow.getDayName()}FullName'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w700,
            color: fontColor ?? context.theme.colorScheme.primaryContainer,
            height: 1.2,
          ),
        ),
        Text(
          '${EventController.instance.hijriNow.hDay.toString().convertNumbers()} ${EventController.instance.hijriNow.getLongMonthName().tr}',
          style: TextStyle(
            fontSize: 18.sp,
            fontFamily: 'cairo',
            fontWeight: FontWeight.w700,
            color: fontColor ?? context.theme.colorScheme.primaryContainer,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
