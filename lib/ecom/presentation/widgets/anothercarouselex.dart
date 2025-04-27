
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_images.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AnotherCarouselEx extends StatelessWidget {
  const AnotherCarouselEx({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 170,
          width: double.infinity,
          color: AppColors.white,
          child: AnotherCarousel(
            images: [
              Image.asset(AppImages.offer1, fit: BoxFit.cover),
              Image.asset(AppImages.offer2, fit: BoxFit.cover),
            ],
            dotSize: 6,
            dotColor: AppColors.grey600,
            dotIncreasedColor: AppColors.black,
            dotBgColor: AppColors.grey200,
            indicatorBgPadding: 5,
          ),
        ),
      ),
    );
  }
}
