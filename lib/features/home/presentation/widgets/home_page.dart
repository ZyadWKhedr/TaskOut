import 'package:flutter/material.dart';
import 'package:task_out/core/constants/app_colors.dart';
import 'package:task_out/core/utils/app_sizes.dart';
import 'package:task_out/features/home/presentation/pages/calender_page.dart';
import 'package:task_out/features/home/presentation/pages/category_page.dart';
import 'package:task_out/features/home/presentation/pages/profile_page.dart';
import 'package:task_out/features/home/presentation/pages/home_screen.dart';
import 'package:task_out/features/home/presentation/widgets/add_category_form.dart';
import 'package:task_out/features/home/presentation/widgets/add_task_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CategoryPage(),
    CalenderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          _currentIndex == 3 || _currentIndex == 2
              ? null
              : FloatingActionButton(
                backgroundColor: AppColors.mainColor,
                onPressed: () => _onFabPressed(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusLg * 2,
                  ),
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: AppSizes.textSm,
            selectedItemColor: AppColors.mainColor,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            unselectedFontSize: AppSizes.textSm,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFabPressed(BuildContext context) {
    if (_currentIndex == 0) {
      // HomeScreen FAB: Add Task
      _showAddTaskBottomSheet(context);
    } else if (_currentIndex == 1) {
      // CategoryScreen FAB: Add Category
      _showAddCategoryBottomSheet(context);
    }
  }

  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: AddTaskForm(),
        );
      },
    );
  }

  void _showAddCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: AddCategoryForm(),
        );
      },
    );
  }
}
