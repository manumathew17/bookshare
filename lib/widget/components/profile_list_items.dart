import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_style.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final IconData tailIcon;
  final VoidCallback onClick;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onClick,
    this.tailIcon = Icons.chevron_right_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade300,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              this.text,
              style: heading1,
            ),
            Spacer(),
            Icon(
              tailIcon,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
