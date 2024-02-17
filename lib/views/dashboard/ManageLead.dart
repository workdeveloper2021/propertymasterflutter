// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/RealEstateModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/utilities/LeadBox.dart';
import 'package:propertymaster/views/ManageLeadList.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
// apis

class ManageLead extends StatefulWidget {
  const ManageLead({super.key});

  @override
  State<ManageLead> createState() => _ManageLeadState();
}

class _ManageLeadState extends State<ManageLead> {
  late String userID;
  late String role;
  String type = "all";
  Data? realEstateCounts;
  var searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
      allProcess();
    });
  }

  Future<void> allProcess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString("userID") ?? '';
    role = prefs.getString("role") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    realEstateAPI(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
          child: Column(
            children: [
              const Row(
                children: [
                  // const SizedBox(width: 10.0,),
                  Text(AppStrings.manageLead,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
                ],
              ),
              const SizedBox(height: 20.0,),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        alignment: Alignment.topCenter,
                        duration: const Duration(milliseconds: 750),
                        isIos: true,
                        child: const ManageLeadList(title: AppStrings.totalLeads,page: 'all'),
                      )
                  );
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.colorSecondary,
                        width: 1.0,
                        style: BorderStyle.solid
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 23.0,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: Text(
                          AppStrings.searchLeads,
                          style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.textColorGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorSecondaryLight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 750),
                            isIos: true,
                            child: const ManageLeadList(title: AppStrings.totalLeads,page: 'totalleads'),
                          )
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: 90.0,
                          padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                          decoration: const BoxDecoration(
                            color: AppColors.colorSecondary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0,),
                              topRight: Radius.circular(5.0,),
                              bottomLeft: Radius.circular(0.0,),
                              bottomRight: Radius.circular(0.0,),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(FontAwesomeIcons.house,color: AppColors.white),
                                  SizedBox(width: 5.0,),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      AppStrings.totalLeads,
                                      style: TextStyle(color: AppColors.white,fontSize: 12.0,),
                                    ),
                                  ),
                                ],
                              ),
                              Text(realEstateCounts == null ? '${AppStrings.pending} : 0' : '${AppStrings.pending} : ${realEstateCounts!.otherlead!.pending.toString()}',
                                style: const TextStyle(color: AppColors.white,fontSize: 12.0,),
                              ),
                              Text(realEstateCounts == null ? '0' : realEstateCounts!.totallead.toString(),
                                style: const TextStyle(color: AppColors.white,fontSize: 24.0,),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.colorSecondaryDashboard,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0,),
                              topRight: Radius.circular(0.0,),
                              bottomLeft: Radius.circular(5.0,),
                              bottomRight: Radius.circular(5.0,),
                            ),
                          ),
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.todaylead.toString(),
                  heading: AppStrings.todayLeads,
                  primaryColor: AppColors.orange,
                  secondaryColor: AppColors.orangeLight,
                  isAvailable: true,
                  icon: const Icon(Icons.today,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.todayLeads,page: 'totaltodayleads'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.todaywork.toString(),
                  heading: AppStrings.todayWork,
                  primaryColor: AppColors.colorSecondary,
                  secondaryColor: AppColors.colorSecondaryDashboard,
                  isAvailable: true,
                  icon: const Icon(Icons.work_history_outlined,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.todayWork,page: 'totaltodaywork'),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.hotlisted.toString(),
                  heading: AppStrings.hotListed,
                  primaryColor: AppColors.colorSecondaryDark,
                  secondaryColor: AppColors.colorSecondaryLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.fireFlameCurved,color: AppColors.white),
                  pageLink: const ManageLeadList(title: AppStrings.hotListed,page: 'totalhotlisted'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.upcomingVisits.toString(),
                  heading: AppStrings.upcomingVisits,
                  primaryColor: AppColors.colorSecondary,
                  secondaryColor: AppColors.colorSecondaryDashboard,
                  isAvailable: true,
                  icon: const Icon(Icons.data_thresholding_outlined,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.upcomingVisits,page: 'totalupcomingvisits'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.holdBeforeVisit.toString(),
                  heading: AppStrings.holdBeforeVisit,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.handHoldingDollar,color: AppColors.white),
                  pageLink: const ManageLeadList(title: AppStrings.holdBeforeVisit,page: 'totalholdbeforevisit'),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.rejectBeforeVisit.toString(),
                  heading: AppStrings.rejectBeforeVisit,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                  // icon: const Icon(FontAwesomeIcons.bolt,color: AppColors.white),
                  icon: const Icon(FontAwesomeIcons.ban,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.rejectBeforeVisit,page: 'totalrejectbeforevisit'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.visitDone.toString(),
                  heading: AppStrings.visitDone,
                  primaryColor: AppColors.orange,
                  secondaryColor: AppColors.orangeLight,
                  isAvailable: true,
                  icon: const Icon(Icons.done_all,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.visitDone,page: 'totalvisitdone'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.booked.toString(),
                  heading: AppStrings.booked,
                  primaryColor: AppColors.green,
                  secondaryColor: AppColors.greenLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.locationCrosshairs,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.booked,page: 'totalbooked'),
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            Row(
              children: [
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.hold.toString(),
                  heading: AppStrings.holdAfterVisit,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.handHoldingDollar,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.holdAfterVisit,page: 'totalhold'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.reject.toString(),
                  heading: AppStrings.reject,
                  primaryColor: AppColors.carrotColorDark,
                  secondaryColor: AppColors.carrotColorLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.ban,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.reject,page: 'totalreject'),
                ),
                const SizedBox(width: 10.0,),
                LeadBoxes(
                  count: realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.registered.toString(),
                  heading: AppStrings.registered,
                  primaryColor: AppColors.green,
                  secondaryColor: AppColors.greenLight,
                  isAvailable: true,
                  icon: const Icon(FontAwesomeIcons.registered,color: AppColors.white,),
                  pageLink: const ManageLeadList(title: AppStrings.registered,page: 'totalregistered'),
                ),
              ],
            ),
            // const SizedBox(height: 10.0,),
            // Row(
            //   children: [
            //     LeadBoxes(
            //       count: '0',
            //       heading: AppStrings.totalBPLeads,
            //       primaryColor: AppColors.parrotColorDark,
            //       secondaryColor: AppColors.parrotColorLight,
            //       isAvailable: true,
            //       pageLink: const RealEstateDetail(title: AppStrings.totalBPLeads,page: 'totalbpleads'),
            //     ),
            //     const SizedBox(width: 10.0,),
            //     LeadBoxes(
            //       count: '0',
            //       heading: AppStrings.todayBPLeads,
            //       primaryColor: AppColors.orange,
            //       secondaryColor: AppColors.orangeLight,
            //       isAvailable: true,
            //       pageLink: const RealEstateDetail(title: AppStrings.todayBPLeads,page: 'todaybpleads'),
            //     ),
            //     const SizedBox(width: 10.0,),
            //     LeadBoxes(
            //       count: '0',
            //       heading: AppStrings.todayBPWork,
            //       primaryColor: AppColors.colorSecondary,
            //       secondaryColor: AppColors.colorSecondaryDashboard,
            //       isAvailable: true,
            //       pageLink: const RealEstateDetail(title: AppStrings.todayBPWork,page: 'todaybpworks'),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
  // real estate api
  Future<void> realEstateAPI(BuildContext context) async {
    Loader.ProgressloadingDialog(context, true);
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(Urls.realEstateUrl),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      request.fields['user_id'] =  userID;
      request.fields['role'] =  role;
      request.fields['type'] =  type;
      var response = await request.send();
      Loader.ProgressloadingDialog(context, false);
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(Urls.leadsListUrl);
        Map<String, dynamic> map = convert.jsonDecode(event);
        RealEstateModel response = await RealEstateModel.fromJson(map);
        Utilities().toast(response.message);
        if(response.status == true){
          realEstateCounts = response.data;
          setState(() {});
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // real estate api
}