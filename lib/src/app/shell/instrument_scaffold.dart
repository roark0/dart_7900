import 'package:flutter/material.dart';

import '../navigation/navigation.dart';
import '../../core/theme/theme.dart';

class InstrumentScaffold extends StatelessWidget {
  const InstrumentScaffold({
    super.key,
    required this.selectedModule,
    required this.onModuleChanged,
    required this.content,
    required this.clockText,
    this.sideMenu = const <SideNavItem>[],
    this.selectedSideIndex = 0,
    this.onSideChanged,
  });

  final TopModule selectedModule;
  final ValueChanged<TopModule> onModuleChanged;
  final Widget content;
  final String clockText;
  final List<SideNavItem> sideMenu;
  final int selectedSideIndex;
  final ValueChanged<int>? onSideChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: UiPalette.frameBackground,
      child: Column(
        children: <Widget>[
          _TopBar(selectedModule: selectedModule, onChanged: onModuleChanged),
          Expanded(
            child: Row(
              children: <Widget>[
                if (sideMenu.isNotEmpty)
                  _SideBar(
                    items: sideMenu,
                    selectedIndex: selectedSideIndex,
                    onChanged: onSideChanged,
                  ),
                Expanded(child: content),
              ],
            ),
          ),
          _BottomBar(clockText: clockText),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.selectedModule, required this.onChanged});

  final TopModule selectedModule;
  final ValueChanged<TopModule> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UiMetrics.topBarHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[UiPalette.chromeTopLight, UiPalette.chromeTop],
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 14),
          const _MenuEntry(),
          const SizedBox(width: UiMetrics.space6),
          ...topNavItems.map(
            (TopNavItem item) => Expanded(
              child: _TopTab(
                item: item,
                selected: item.module == selectedModule,
                onTap: () => onChanged(item.module),
              ),
            ),
          ),
          const SizedBox(width: UiMetrics.space8),
        ],
      ),
    );
  }
}

class _MenuEntry extends StatelessWidget {
  const _MenuEntry();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      child: Row(
        children: const <Widget>[
          Text('Menu', style: UiTypography.topMenuLabel),
          Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

class _TopTab extends StatelessWidget {
  const _TopTab({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final TopNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          top: UiMetrics.space2,
          right: UiMetrics.space2,
        ),
        decoration: BoxDecoration(
          color: selected ? UiPalette.selectedTab : Colors.transparent,
          borderRadius: selected
              ? const BorderRadius.only(
                  topLeft: Radius.circular(UiMetrics.buttonRadius),
                  topRight: Radius.circular(UiMetrics.buttonRadius),
                )
              : BorderRadius.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.icon,
              color: selected ? Colors.black : Colors.white,
              size: 26,
            ),
            const SizedBox(height: UiMetrics.space2),
            Text(
              item.label,
              style: UiTypography.navLabel.copyWith(
                color: selected ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideBar extends StatelessWidget {
  const _SideBar({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<SideNavItem> items;
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      color: UiPalette.sideNav,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: UiMetrics.space4,
          horizontal: UiMetrics.space2,
        ),
        itemCount: items.length,
        separatorBuilder: (_, int index) =>
            const SizedBox(height: UiMetrics.space2),
        itemBuilder: (BuildContext context, int index) {
          final bool selected = index == selectedIndex;
          return GestureDetector(
            onTap: onChanged == null ? null : () => onChanged!(index),
            child: Container(
              height: UiMetrics.sideButtonHeight,
              decoration: BoxDecoration(
                color: selected
                    ? UiPalette.sideNavSelected
                    : UiPalette.sideNavButtonIdle,
                border: Border.all(color: UiPalette.sideNavBorder),
                borderRadius: BorderRadius.circular(UiMetrics.buttonRadius),
              ),
              alignment: Alignment.center,
              child: Text(
                items[index].label,
                textAlign: TextAlign.center,
                style: UiTypography.buttonLabel,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.clockText});

  final String clockText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UiMetrics.bottomBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: UiMetrics.space4),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[UiPalette.chromeTopLight, UiPalette.footer],
        ),
      ),
      child: Row(
        children: <Widget>[
          const Text('Engineer', style: UiTypography.status),
          const Spacer(),
          const Icon(Icons.arrow_right_alt, color: Colors.white),
          const Text('LIS', style: UiTypography.status),
          const SizedBox(width: 36),
          Text(clockText, style: UiTypography.status),
          const SizedBox(width: 14),
          Container(
            width: 19,
            height: 19,
            decoration: const BoxDecoration(
              color: UiPalette.success,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              '?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
