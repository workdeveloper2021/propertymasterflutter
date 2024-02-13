// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:propertymaster/models/PropertyDataModel.dart';
import 'package:propertymaster/utilities/AppColors.dart';
import 'package:propertymaster/utilities/urls.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:propertymaster/views/PropertyDetail.dart';

class HomeSlider extends StatefulWidget {
  List<Listing>? imgList;

  HomeSlider({required this.imgList});

  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.imgList!
        .map((item) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    alignment: Alignment.topCenter,
                    duration: const Duration(milliseconds: 750),
                    isIos: true,
                    child: PropertyDetail(propertyData: item),
                  )
              );
            },
            child: Stack(
                children: [
                  /*Image.network(
                    Urls.imageUrl + item.image.toString(),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 283.0,
                  ),*/
                  CachedNetworkImage(
                    imageUrl: Urls.imageUrl + item.image.toString(),
                    width: MediaQuery.of(context).size.width,
                    height: 283.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(child: Image.asset('assets/icons/spinner.gif',width: 64.0,)),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Positioned(
                    bottom: 40.0,
                    left: 15.0,
                    right: 0.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(0, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0.0,10.0,20.0,10.0,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // '20% off on your\nfirst purchase',
                            item.location!,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          );
        })
        .toList();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0, bottom: 10.0),
          child: CarouselSlider(
            items: imageSliders,
            options: CarouselOptions(
                autoPlay: true,
                pauseAutoPlayInFiniteScroll: true,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                aspectRatio: 1.4,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 20.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList!.map((url) {
              int index = widget.imgList!.indexOf(url);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 3,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _current == index ? AppColors.colorPrimary : Colors.white,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
