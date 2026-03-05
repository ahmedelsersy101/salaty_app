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
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeIndex,
            selectedItemColor: context.theme.colorScheme.primary,
            unselectedItemColor:
                context.theme.colorScheme.onSurface.withValues(alpha: .6),
            type: BottomNavigationBarType.fixed,
            backgroundColor: context.theme.colorScheme.surface,
            elevation: 8,
            items: NavBarTab.values
                .map((nav) => BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: customSvgWithColor(
                          height: 24,
                          width: 24,
                          nav.icon,
                          color: controller.currentIndex == nav.tapIndex
                              ? context.theme.colorScheme.primary
                              : context.theme.colorScheme.onSurface
                                  .withValues(alpha: .6),
                        ),
                      ),
                      label: nav.label.tr,
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
