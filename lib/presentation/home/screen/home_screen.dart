part of '../home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة الكنترولر
    Get.put(HomeController());

    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: NavBarTab.values
              .map((nav) => nav.currentScreen)
              .toList()[controller.currentIndex],
          floatingActionButton: FloatyNavBar(
            backgroundColor:
                context.theme.colorScheme.primary.withValues(alpha: .8),
            selectedTab: controller.currentIndex,
            tabs: NavBarTab.values
                .map((nav) => FloatyTab(
                      isSelected: controller.currentIndex == nav.tapIndex,
                      title: nav.label.tr,
                      selectedColor: context.theme.colorScheme.surface,
                      unselectedColor: Colors.transparent,
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: context.theme.canvasColor.withValues(alpha: .6),
                      ),
                      icon: customSvgWithColor(
                        height: 60,
                        width: 60,
                        nav.icon,
                        color: controller.currentIndex == nav.tapIndex
                            ? context.theme.colorScheme.primary
                            : context.theme.colorScheme.surface
                                .withValues(alpha: .6),
                      ),
                      onTap: () => controller.changeIndex(nav.tapIndex),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
