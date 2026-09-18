import 'package:easy_localization/easy_localization.dart';
import 'package:evently/generated/locale_keys.g.dart';
import 'package:evently/ui/home/tabs/favorite/favorite_tab.dart';
import 'package:evently/ui/home/tabs/home/home_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_routes.dart';
import 'package:evently/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs=[
    HomeTab(),
    FavoriteTab(),
    ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          selectedIndex=index;
          setState(() {
          });
        },
       currentIndex: selectedIndex,
        items: [
          _bottomNavigationBarItem(
            label: LocaleKeys.home.tr(),
            selectedIcon: AppIcons.selectedHome,
            unSelectedIcon: AppIcons.unselectedHome,
            isSelected: selectedIndex == 0,
          ),
          _bottomNavigationBarItem(
            label: LocaleKeys.favorite.tr(),
            selectedIcon: AppIcons.selectedFavorite,
            unSelectedIcon: AppIcons.unselectedFavorite,
            isSelected: selectedIndex == 1,
          ),
          _bottomNavigationBarItem(
            label: LocaleKeys.profile.tr(),
            selectedIcon: AppIcons.selectedProfile,
            unSelectedIcon: AppIcons.unselectedProfile,
            isSelected: selectedIndex == 2,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AppRoutes.addEventRouteName);
      },
      child: Icon(Icons.add),),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem({
    required String label,
    required String selectedIcon,
    required String unSelectedIcon,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(isSelected ? selectedIcon : unSelectedIcon)),
      label: label,
    );
  }
}
