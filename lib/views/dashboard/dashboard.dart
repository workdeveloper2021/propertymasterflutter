import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/dashboard/Home.dart';
import 'package:propertymaster/views/dashboard/MyTeam.dart';
import 'package:propertymaster/views/dashboard/ManageLead.dart';
import 'package:propertymaster/views/dashboard/ResaleDeal.dart';

class Dashboard extends StatefulWidget {
  int bottomIndex;
  Dashboard({super.key,required this.bottomIndex});

  @override
  State<Dashboard> createState() => _DashboardState();
}

var widgetOptions = [
  const Home(),
  const MyTeam(),
  const ManageLead(),
  const ResaleDeal(),
];
class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        widget.bottomIndex = index;
        // print("index--------------------${widget.bottomIndex}");
      });
    }
    return Scaffold(
      body: widgetOptions[
        widget.bottomIndex
      ],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home.svg',color: AppColors.white,width: 25.0,height: 25.0,),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/my_team.svg',color: AppColors.white,width: 25.0,height: 25.0,),
            label: AppStrings.myTeam,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/real_estate.svg',color: AppColors.white,width: 25.0,height: 25.0,),
            label: AppStrings.manageLead,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/resale_deal.svg',color: AppColors.white,width: 25.0,height: 25.0,),
            label: AppStrings.resaleLead,
          ),
        ],
        currentIndex: widget.bottomIndex,
        elevation: 0.0,
        backgroundColor: AppColors.colorSecondaryLight,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        onTap: onItemTapped,
        selectedFontSize: 12.0,
        // unselectedFontSize: 10.0,
      )
    );
  }
}
