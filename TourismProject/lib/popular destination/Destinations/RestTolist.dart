import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'restaurant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestListItem extends StatelessWidget {
  final Rest rest;
  final int activeIndex;
  final List<String> imagePaths;

  RestListItem(this.rest, this.activeIndex, this.imagePaths);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: rest.imagePaths
              .map((imagePath) => Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: 180.h,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlay: false,
            enlargeCenterPage: true,
          ),
        ),
        SizedBox(height: 10.h),
        buildIndicator(activeIndex, imagePaths.length),
        SizedBox(height: 10.h),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(width: 8.w),
                Text(
                  rest.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MadimiOne',
                    color: Color.fromARGB(255, 83, 137, 182),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 5, 59, 107),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to Trip!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Color.fromARGB(255, 13, 16, 74),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: Color.fromARGB(255, 13, 16, 74),
                  ),
                ),
              ],
            )),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            rest.description,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 36, 108, 163),
              fontFamily: 'MadimiOne',
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget buildIndicator(int activeIndex, int length) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: length,
        effect: WormEffect(
          dotWidth: 18.w,
          dotHeight: 18.h,
          activeDotColor: Colors.blue,
          dotColor: Color.fromARGB(255, 16, 65, 106),
        ),
      ),
    );
  }
}
