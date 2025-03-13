import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:git_explorer/core/localization/app_localizations_extension.dart';
import 'package:git_explorer/core/router/app_router.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), SettingsRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: context.l10n.dashboard_home_tab,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: context.l10n.dashboard_settings_tab,
              ),
            ],
          ),
        );
      },
    );
  }
}
