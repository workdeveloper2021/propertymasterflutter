import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/utilities/AppColors.dart';

class LeadBoxes extends StatefulWidget {
  String? count;
  String? heading;
  Color? primaryColor;
  Color? secondaryColor;
  bool isAvailable;
  Widget? pageLink;
  Widget? icon;
  LeadBoxes({super.key,this.count,this.heading,this.primaryColor,this.secondaryColor,required this.isAvailable,this.pageLink, this.icon});

  @override
  State<LeadBoxes> createState() => _LeadBoxesState();
}

class _LeadBoxesState extends State<LeadBoxes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: widget.isAvailable == false ?
      const Center() :
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 750),
                isIos: true,
                child: widget.pageLink!,
              )
          );
        },
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: 90.0,
              padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,3.0,),
              decoration: BoxDecoration(
                color: widget.primaryColor,
                borderRadius: const BorderRadius.only(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Icon(Icons.today,color: AppColors.white),
                      widget.icon!,
                      const SizedBox(width: 5.0,),
                      Expanded(
                        flex: 1,
                        child: Text(widget.heading!,
                          style: const TextStyle(color: AppColors.white,fontSize: 12.0,),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Text(widget.count!,
                    style: const TextStyle(color: AppColors.white,fontSize: 24.0,),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: widget.secondaryColor,
                borderRadius: const BorderRadius.only(
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
    );
  }
}
