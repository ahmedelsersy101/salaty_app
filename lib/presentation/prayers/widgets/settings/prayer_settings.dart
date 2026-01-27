part of '../../prayers.dart';

class PrayerSettings extends StatelessWidget {
  const PrayerSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'prayerSetting'.tr,
          style: TextStyle(
            color: Theme.of(Get.context!).colorScheme.inversePrimary,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
        foregroundColor: Theme.of(Get.context!).colorScheme.inversePrimary,
      ),
      backgroundColor: context.theme.colorScheme.primaryContainer,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GetBuilder<GeneralController>(builder: (generalCtrl) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomSwitchWidget(
                  controller: GeneralController.instance,
                  title: 'detectLocation',
                  value: generalCtrl.state.activeLocation.value,
                  startPadding: 16.0,
                  endPadding: 16.0,
                  onChanged: (bool value) =>
                      generalCtrl.toggleLocationService(),
                ),
                const Gap(8),
                AdhanSounds(),
                const Gap(8),
                SetTimingCalculations(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
