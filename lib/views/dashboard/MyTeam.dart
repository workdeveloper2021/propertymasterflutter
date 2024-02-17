import 'package:flutter/material.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/LeadBox.dart';

class MyTeam extends StatefulWidget {
  const MyTeam({super.key});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(AppStrings.myTeam),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorSecondaryLight,
        title: const Text(
          AppStrings.teamDashboard,
          style: TextStyle(color: AppColors.white,),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.totalBP,
                  primaryColor: AppColors.colorPrimaryDark,
                  secondaryColor: AppColors.primaryColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.todayBP,
                  primaryColor: AppColors.colorPrimaryDark,
                  secondaryColor: AppColors.primaryColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.activeBP,
                  primaryColor: AppColors.colorPrimaryDark,
                  secondaryColor: AppColors.primaryColorLight,
                  isAvailable: true,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.partTimeBP,
                  primaryColor: AppColors.colorSecondaryDark,
                  secondaryColor: AppColors.colorSecondaryLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.fullTimeBP,
                  primaryColor: AppColors.colorSecondaryDark,
                  secondaryColor: AppColors.colorSecondaryLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.srBP,
                  primaryColor: AppColors.colorSecondaryDark,
                  secondaryColor: AppColors.colorSecondaryLight,
                  isAvailable: true,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.completeKYCBusiness,
                  primaryColor: AppColors.colorSecondary,
                  secondaryColor: AppColors.colorSecondaryDashboard,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.pendingKYCBusiness,
                  primaryColor: AppColors.colorSecondary,
                  secondaryColor: AppColors.colorSecondaryDashboard,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.rejectBP,
                  primaryColor: AppColors.colorSecondary,
                  secondaryColor: AppColors.colorSecondaryDashboard,
                  isAvailable: true,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.currentContestInfo,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.top10BP,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.contestQualifier,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.ourProjects,
                  primaryColor: AppColors.colorPrimaryDark,
                  secondaryColor: AppColors.primaryColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: '0',
                  heading: AppStrings.totalLeadsStatus,
                  primaryColor: AppColors.colorPrimaryDark,
                  secondaryColor: AppColors.primaryColorLight,
                  isAvailable: true,
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  isAvailable: false,
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}
