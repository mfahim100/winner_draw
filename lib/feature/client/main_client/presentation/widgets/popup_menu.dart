import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../core/constants/const_colors.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu(
      {Key? key,
      required this.aboutUsCallback,
      required this.accountCallback,
      required this.helpCallback,
      required this.logoutCallback})
      : super(key: key);
  final VoidCallback accountCallback;
  final VoidCallback aboutUsCallback;
  final VoidCallback helpCallback;
  final VoidCallback logoutCallback;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.menu,
          color: ConstColors.kTextFieldBGColor,
          size: 25.sp,
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: accountCallback,
                child:
                    const TextButton(onPressed: null, child: Text('Account')),
              ),
              PopupMenuItem(
                onTap: aboutUsCallback,
                child:
                    const TextButton(onPressed: null, child: Text('About Us')),
              ),
              PopupMenuItem(
                onTap: helpCallback,
                child: const TextButton(onPressed: null, child: Text('Help')),
              ),
              PopupMenuItem(
                onTap: logoutCallback,
                child: const TextButton(onPressed: null, child: Text('Logout')),
              ),
            ]);
  }
}
