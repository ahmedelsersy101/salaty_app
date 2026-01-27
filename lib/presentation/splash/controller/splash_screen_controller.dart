part of '../splash.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get instance =>
      GetInstance().putOrFind(() => SplashScreenController());

  SplashState state = SplashState();

  @override
  Future<void> onInit() async {
    _loadInitialData();
    Future.delayed(const Duration(milliseconds: 4300))
        .then((_) async => await changeCustomWidget());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void toggleSlider({required int duration}) {
    final height = Get.height;
    openSlider(duration: duration, height: height);
    closeSlider(duration: duration + 700, height: 0.0);
  }

  void openSlider({required int duration, required double height}) {
    Future.delayed(Duration(milliseconds: duration))
        .then((_) => state.firstContainerHeight.value = height);
    Future.delayed(Duration(milliseconds: duration + 200))
        .then((_) => state.secondContainerHeight.value = height);
  }

  void closeSlider({required int duration, required double height}) {
    Future.delayed(Duration(milliseconds: duration))
        .then((_) => state.secondContainerHeight.value = height);
    Future.delayed(Duration(milliseconds: duration + 200))
        .then((_) => state.firstContainerHeight.value = height);
  }

  Future<void> changeCustomWidget() async {
    if (LocationHelper().locationIsEmpty) {
      toggleSlider(duration: 0);
      Future.delayed(
        const Duration(milliseconds: 600),
        () => state.customWidgetIndex.value = 1,
      );
    } else {
      await isNotificationAllowed();
    }
  }

  Future<void> isNotificationAllowed() async {
    bool isAllowed = await NotifyHelper().isNotificationAllowed();
    if (!isAllowed) {
      toggleSlider(duration: 0);
      Future.delayed(
        const Duration(milliseconds: 600),
        () => state.customWidgetIndex.value = 2,
      );
    } else {
      toggleSlider(duration: 0);
      Future.delayed(
        const Duration(milliseconds: 900),
        () => Get.offAndToNamed(AppRouter.homeScreen),
      );
    }
  }

  Widget get customWidget {
    switch (state.customWidgetIndex.value) {
      case 0:
        return AnimatedDrawingWidget(
          customColor: Get.theme.canvasColor,
        );
      case 1:
        return ActiveLocationWidget();
      case 2:
        return ActiveNotificationWidget();
      default:
        return AnimatedDrawingWidget(
          customColor: Get.theme.canvasColor,
        );
    }
  }

  /// -------- [Methods] ----------

  Future<void> activateNotifications() async {
    try {
      state.isNotificationLoading.value = true;

      if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
        await MacOSNotificationsService.instance.initialize();
        final granted =
            await MacOSNotificationsService.instance.requestPermissions();

        await GetStorage().write('notifications_permission_granted', granted);

        NotifyHelper().markNotificationSetupAsSeen();

        toggleSlider(duration: 0);
        Future.delayed(
          const Duration(milliseconds: 900),
          () => Get.offAndToNamed(AppRouter.homeScreen),
        );
      } else {
        await NotifyHelper().requistPermissions();
        NotifyHelper.initAwesomeNotifications();

        NotifyHelper().markNotificationSetupAsSeen();

        toggleSlider(duration: 0);
        Future.delayed(
          const Duration(milliseconds: 900),
          () => Get.offAndToNamed(AppRouter.homeScreen),
        );
      }
    } finally {
      state.isNotificationLoading.value = false;
    }
  }

  Future<void> _loadInitialData() async {
    SettingsController.instance.loadLang();
    GeneralController.instance.updateGreeting();
  }

  Widget ramadhanOrEidGreeting() {
    if (state.today.hMonth == 9) {
      return ramadanOrEid('ramadan_white', height: 100.0);
    } else if (GeneralController.instance.eidDays) {
      return ramadanOrEid('eid_white', height: 100.0);
    } else {
      return const SizedBox.shrink();
    }
  }
}
