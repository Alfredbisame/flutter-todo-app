import 'package:bloc_todo/utils/dimensions.dart';
import 'package:bloc_todo/utils/utilities.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../theme/app.colors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final User user;
  final Function() handleLogout;
  const HomeAppBar({super.key, required this.user, required this.handleLogout});

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
              "Welcome, ${user.name!.getLastName()}!",
              style: TextStyle(
                fontSize: 24.width,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            //avatar image
            // Container(
            //   width: 40.width,
            //   height: 40.height,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       image: AssetImage(Resources.profileImage),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            IconButton(
              onPressed: handleLogout,
              icon: Icon(Icons.logout_rounded, size: 28.iconSize),
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
