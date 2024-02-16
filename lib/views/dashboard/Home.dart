// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:propertymaster/models/PropertyDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/AddLead.dart';
import 'package:propertymaster/views/HomeDashboardPropertySlider.dart';
import 'package:propertymaster/views/ManageLeadList.dart';
import 'package:propertymaster/views/authentication/loginRegisteredUser.dart';
import 'package:propertymaster/views/home_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:propertymaster/models/RealEstateModel.dart';
// apis
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:propertymaster/utilities/Loader.dart';
import 'package:propertymaster/utilities/Utility.dart';
import 'package:propertymaster/utilities/Urls.dart' ;
// apis

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var searchController = TextEditingController();
  late String userID;
  String role = '';
  String name = '';
  String type = "all";
  Data? realEstateCounts;
  List<Listing>? imgList = [];
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
    name = prefs.getString("name") ?? '';
    print('my userID is >>>>> {$userID}');
    print('my role is >>>>> {$role}');
    realEstateAPI(context);
    // propertyDataAPI(context);
    propertyDataAPI2(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(role),
              decoration: const BoxDecoration(color: AppColors.colorSecondaryLight,),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text("About"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.grid_3x3_outlined),
              title: const Text("Products"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text("Contact"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLogin", false);
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    duration: const Duration(milliseconds: 750),
                    isIos: true,
                    child: const LoginRegisteredUser(),
                  ),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 140.0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => _scaffoldkey.currentState!.openDrawer(),
                    child: SvgPicture.asset('assets/icons/menu.svg',color: AppColors.white,width: 25.0,height: 25.0,),
                  ),
                  const SizedBox(width: 10.0,),
                  const Text(AppStrings.propertyMaster,style: TextStyle(fontSize: 22.0,color: AppColors.white,),),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50.0,),),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0,),
                        child: const Text(AppStrings.postProperty,style: TextStyle(fontSize: 12.0,),),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Container(
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
                        color: AppColors.colorSecondary,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 14.0, color: AppColors.black,
                        ),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          hintText: AppStrings.searchProperties,
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.colorSecondaryLight,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imgList!.isEmpty
                ? const SizedBox(
                    height: 283.0,
                    child: Center(
                      child: Text(
                        'No data yet !',
                        style: TextStyle(color: AppColors.colorSecondary),
                      ),
                    ),
                  )
                : HomeSlider(imgList: imgList),
            const SizedBox(height: 10.0,),
            HomeDashboardPropertySlider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeftWithFade,
                            alignment: Alignment.topCenter,
                            duration: const Duration(milliseconds: 750),
                            isIos: true,
                            child: const AddLead(),
                          )
                      );
                    },
                    highlightColor: AppColors.transparent,
                    splashColor: AppColors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10.0,),
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: AppColors.colorSecondary,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Text(
                        AppStrings.submitYourLead,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
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
                                  child: const ManageLeadList(title: AppStrings.totalLeads,page: 'totaltodaywork'),
                                )
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: AppColors.carrotColorDark,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/bell.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(AppStrings.todayWork,
                                          style: TextStyle(color: AppColors.white,fontSize: 11.0,),
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Text(realEstateCounts == null ? '0' : realEstateCounts!.todaywork.toString(),
                                          style: const TextStyle(color: AppColors.white,fontSize: 20.0,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0,),
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
                                  child: const ManageLeadList(title: AppStrings.totalLeads,page: 'totalhotlisted'),
                                )
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/fire.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(AppStrings.hotListed,
                                          style: TextStyle(color: AppColors.white,fontSize: 11.0,),
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Text(realEstateCounts == null ? '0' : realEstateCounts!.otherlead!.hotlisted.toString(),
                                          style: const TextStyle(color: AppColors.white,fontSize: 20.0,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5.0,),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //       type: PageTransitionType.rightToLeftWithFade,
                            //       alignment: Alignment.topCenter,
                            //       duration: const Duration(milliseconds: 750),
                            //       isIos: true,
                            //       child: const HomeScreen(),
                            //     )
                            // );
                          },
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1,
                                padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
                                decoration: const BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.all(Radius.circular(5.0,),),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/users-alt.png',width: 20.0,color: AppColors.white,),
                                    const SizedBox(width: 5.0,),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(AppStrings.totalBP2,
                                          style: TextStyle(color: AppColors.white,fontSize: 11.0,),
                                        ),
                                        SizedBox(height: 5.0,),
                                        Text('0',
                                          style: TextStyle(color: AppColors.white,fontSize: 20.0,),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // real estate api
  Future<void> realEstateAPI(BuildContext context) async {
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
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(Urls.leadsListUrl);
        Map<String, dynamic> map = convert.jsonDecode(event);
        RealEstateModel response = await RealEstateModel.fromJson(map);
        if(response.status == true){
          realEstateCounts = response.data;
          setState(() {});
        }else{
          Utilities().toast(response.message);
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // real estate api
  // property data api
  Future<void> propertyDataAPI(BuildContext context) async {
    try {
      var request = http.MultipartRequest(
        'GET',
        Uri.parse(Urls.propertyDataUrl),
      );
      Map<String, String> header = {
        "content-type": "application/json",
        "accept": "application/json",
        "x-api-key" : Utilities.xApiKey,
      };
      request.headers.addAll(header);
      var response = await request.send();
      response.stream.transform(convert.utf8.decoder).listen((event) async {
        print(event);
        print(Urls.propertyDataUrl);
        Map<String, dynamic> map = convert.jsonDecode(event);
        PropertyDataModel response = await PropertyDataModel.fromJson(map);
        if(response.status == true){
          imgList = response.listing;
          setState(() {});
        }else{
          Utilities().toast(response.message);
        }
      });
    } catch (e) {
      Loader.ProgressloadingDialog(context, false);
      Utilities().toast('error: $e');
    }
  }
  // property data api
  // profileApi api
  Future<void> propertyDataAPI2(BuildContext context) async {
    HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    var response = await http.get(Uri.parse(Urls.propertyDataUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "x-api-key" : Utilities.xApiKey,
        });
    Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
    PropertyDataModel res = await PropertyDataModel.fromJson(jsonResponse);
    if (res.status == true) {
      imgList = res.listing;
      setState(() {});
    } else {
      Utilities().toast(res.message.toString());
      setState(() {});
    }
    return;
  }
// profileApi api
}
