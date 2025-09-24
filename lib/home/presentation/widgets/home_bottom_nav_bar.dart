import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/app_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFFF9F8FD),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
      child: const GNav(
        color: AppColors.greyColor,
        activeColor: Colors.white,
        tabBackgroundColor: AppColors.primaryColor,
        gap: 10,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        tabs: [
          GButton(icon: LineIcons.home, text: 'Home'),
          GButton(icon: LineIcons.book, text: 'Library'),
          GButton(icon: LineIcons.search, text: 'Search'),
          GButton(icon: LineIcons.globe, text: 'Explore'),
          GButton(icon: LineIcons.cog, text: 'Settings'),
        ],
      ),
    );
  }
}
