import 'package:ecom_app/ecom/core/constants/theme/app_colors.dart';
import 'package:ecom_app/ecom/core/lists/icons.dart';
import 'package:ecom_app/ecom/presentation/widgets/anothercarouselex.dart';
import 'package:flutter/material.dart';

class HeaderParts extends StatefulWidget {
  const HeaderParts({super.key});

  @override
  State<HeaderParts> createState() => _HeaderPartsState();
}

class _HeaderPartsState extends State<HeaderParts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
                child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align children to start
          children: [
            Column(
              children: [
                Row(
                  children: firstRowItems.map((item) {
                    return _buildItem(
                      imagePath: item['image']!,
                      name: item['name']!,
                      onTap: () {},
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: secondRowItems.map((item) {
                    return _buildItem(
                      imagePath: item['image']!,
                      name: item['name']!,
                      onTap: () {},
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
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
                hintStyle: TextStyle(color: AppColors.grey700)),
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
                  color: AppColors.white,
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
                fontSize: 17),
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
