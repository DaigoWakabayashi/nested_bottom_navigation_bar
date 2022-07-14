import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:nested_bottom_navigation_bar/enums/tab_item.dart';

/// 各ページの Navigator の状態
final navigatorKeys = <TabItem, GlobalKey<NavigatorState>>{
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.timeline: GlobalKey<NavigatorState>(),
  TabItem.settings: GlobalKey<NavigatorState>(),
};

class BasePage extends HookWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentTab = useState(TabItem.home);

    return Scaffold(
      body: Stack(
        children: TabItem.values
            .map(
              (tabItem) => _TabPage(
                currentTab: currentTab.value,
                tabItem: tabItem,
                navigationKey: navigatorKeys[tabItem]!,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: _BottomNavigationBar(
        currentTab: currentTab.value,
        onSelect: (selectedTab) {
          if (currentTab.value == selectedTab) {
            navigatorKeys[selectedTab]
                ?.currentState
                ?.popUntil((route) => route.isFirst);
          } else {
            // 未選択
            currentTab.value = selectedTab;
          }
        },
      ),
    );
  }
}

class _TabPage extends StatelessWidget {
  const _TabPage({
    required this.currentTab,
    required this.tabItem,
    required this.navigationKey,
  });

  final TabItem currentTab;
  final TabItem tabItem;
  final GlobalKey<NavigatorState> navigationKey;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
        key: navigationKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute<Widget>(
            builder: (context) => tabItem.page,
          );
        },
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    required this.currentTab,
    required this.onSelect,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelect;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: TabItem.values.indexOf(currentTab),
      items: TabItem.values
          .map(
            (tabItem) => BottomNavigationBarItem(
              icon: Icon(tabItem.icon),
              label: tabItem.title,
            ),
          )
          .toList(),
      onTap: (index) {
        onSelect(TabItem.values[index]);
      },
    );
  }
}
