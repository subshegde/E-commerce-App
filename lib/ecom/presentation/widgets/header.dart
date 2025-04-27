import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecom_app/ecom/core/constants/assets/app_images.dart';
import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/lists/icons.dart';
import 'package:ecom_app/ecom/presentation/widgets/anothercarouselex.dart';
import 'package:flutter/material.dart';

class HeaderParts extends StatefulWidget {
  const HeaderParts({super.key});

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

int indexCategory = 0;

class _HeaderPartsState extends State<HeaderParts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topHeader(),
        const SizedBox(
          height: 10,
        ),
        searchBar(),
        const SizedBox(
          height: 10,
        ),
        const AnotherCarouselEx(),
        const SizedBox(
          height: 30,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: firstRowItems.map((item) {
                  return _buildItem(
                    imagePath: item['image']!,
                    name: item['name']!,
                    onTap: () {
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Row(
                children: secondRowItems.map((item) {
                  return _buildItem(
                    imagePath: item['image']!,
                    name: item['name']!,
                    onTap: () {
                      print('Tapped on ${item['name']}');
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15),
        //     child: Container(
        //       width: double.infinity,
        //       height: 60,
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(
        //               AppImages.bg2), // Replace with your image asset
        //           fit: BoxFit.cover,
        //           opacity:
        //               0.8, // Optional: adjust opacity if the image is too intense
        //         ),
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: Text(
        //         'Devivery is 10% \ncheaper!',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 15,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Widget searchBar() {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      padding: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: AppColors.grey200, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.grey700,
                ),
                hintText: "Search..",
                hintStyle: const TextStyle(color: Colors.black26)),
          )),
          Material(
            color: AppColors.grey600,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding topHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color: AppColors.green,
            size: 18,
          ),
          Text(
            "Shimoga, Karnataka",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 17
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildItem({
  required String imagePath,
  required String name,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 50,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
