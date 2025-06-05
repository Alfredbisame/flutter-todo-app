import 'package:flutter/material.dart';

import '../resources/resources.dart';
import '../theme/app.colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Row container with icon and date
            IconButton(onPressed: () {}, icon: Icon(Icons.menu, size: 28)),
            //format date in June 03, 2020
            Text(
              "Welcome, Bhankid",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            //avatar image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(Resources.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.bodyBackgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}
