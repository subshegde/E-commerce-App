import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/presentation/widgets/header.dart';
import 'package:ecom_app/ecom/presentation/widgets/display_product.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              HeaderParts(),
              ItemsDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
