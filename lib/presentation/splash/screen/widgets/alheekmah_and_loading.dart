part of '../../splash.dart';

class AlheekmahAndLoading extends StatelessWidget {
  const AlheekmahAndLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customSvgWithCustomColor(
                SvgPath.svgLogoAqemLogo,
                height:200,
                color: context.theme.colorScheme.surface,
              ),
              RotatedBox(
                quarterTurns: 2,
                child: customLottieWithColor(
                  LottieConstants.assetsLottieSplashLoading,
                  width: 250.0,
                  color: context.theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
