import 'package:ecom_app/ecom/core/constants/assets/app_icons.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key}) 
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 1,
      title: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.grey300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: AppColors.grey700),
                  hintText: "Search..",
                  hintStyle: TextStyle(color: AppColors.grey700),
                ),
              ),
            ),
          ],
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.black),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset(AppIcons.goCart, scale: 20),
          ),
        ),
      ],
    );
  }
}
