import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/AppStrings.dart';
import 'package:propertymaster/views/authentication/OTPVerification.dart';

class LoginFreeUser extends StatefulWidget {
  const LoginFreeUser({super.key});

  @override
  State<LoginFreeUser> createState() => _LoginFreeUserState();
}

class _LoginFreeUserState extends State<LoginFreeUser> {
  var phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20.0,left: 20.0,right: 20.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          width: 30.0,
                          height: 30.0,
                          child: SvgPicture.asset('assets/icons/back.svg'),
                        ),
                        const SizedBox(width: 10.0),
                        const Text(
                          AppStrings.back,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
              const SizedBox(height: 10.0,),
              const Text(
                AppStrings.loginTitle2,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 35.0,
                  color: AppColors.black,
                ),
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
                        'assets/icons/phone.svg',
                        width: 23.0,
                        color: AppColors.colorSecondary,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                            fontSize: 14.0, color: AppColors.black,
                        ),
                        cursorColor: AppColors.textColorGrey,
                        decoration: const InputDecoration(
                          hintText: AppStrings.phoneNumber,
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
              const SizedBox(height: 20.0,),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  color: AppColors.colorSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          alignment: Alignment.topCenter,
                          duration: const Duration(milliseconds: 750),
                          isIos: true,
                          child: const OTPVerification(),
                        )
                    );
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppStrings.logIn,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
