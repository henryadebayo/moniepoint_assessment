import 'package:flutter/material.dart';
import 'package:moniepoint_assessment/core/core.dart';
import 'package:moniepoint_assessment/features/features.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<Offset> _bottomNavAnimationPosition;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _bottomNavAnimationPosition =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animationController);

    animationController.forward();
  }

  final _widgets = [
    const MapView(),
    Container(),
    const HomeView(),
    Container(),
    Container(),
  ];

  final activeIndex = ValueNotifier(2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: activeIndex,
        builder: (context, index, _) {
          return Stack(
            children: [
              _widgets[index],
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: _bottomNavAnimationPosition,
                    child: AppBottomNavigationWidget(
                      items: [
                        BottomNavigationItem(
                          isSelected: index == 0,
                          icon: Icons.search,
                          onTap: () {
                            activeIndex.value = 0;
                          },
                        ),
                        BottomNavigationItem(
                          isSelected: index == 1,
                          icon: Icons.message,
                          onTap: () {
                            activeIndex.value = 1;
                          },
                        ),
                        BottomNavigationItem(
                          isSelected: index == 2,
                          icon: Icons.home,
                          onTap: () {
                            activeIndex.value = 2;
                          },
                        ),
                        BottomNavigationItem(
                          isSelected: index == 3,
                          icon: Icons.favorite_outlined,
                          onTap: () {
                            activeIndex.value = 3;
                          },
                        ),
                        BottomNavigationItem(
                          isSelected: index == 4,
                          icon: Icons.person,
                          onTap: () {
                            activeIndex.value = 4;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
