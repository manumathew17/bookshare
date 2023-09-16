import 'package:bookshare/config/account.dart';
import 'package:bookshare/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../widget/components/profile_list_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cancel_outlined, size: 24),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.w,
                  height: 15.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.w / 2),
                    child: Image.network(
                      "https://imgv3.fotor.com/images/gallery/Realistic-Female-Profile-Picture.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                // SocialIcons(),
                SizedBox(height: 10),
                Text(
                  AccountConfig.userDetail.user.name,
                  style: header.copyWith(color: Colors.black),
                ),
                Text(
                  AccountConfig.userDetail.user.email,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 5.h),
                ProfileListItem(
                  icon: Icons.location_on_rounded,
                  text: '#132 HSR layout opposite hustle hub  \nBenglore\nKarnataka',
                ),
                ProfileListItems(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AppBarButton extends StatelessWidget {
  final IconData icon;

  const AppBarButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [
        BoxShadow(
          color: blackPrimary,
          offset: Offset(1, 1),
          blurRadius: 10,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-1, -1),
          blurRadius: 10,
        ),
      ]),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}

// class AvatarImage extends StatelessWidget {
//   const AvatarImage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       height: 150,
//       padding: EdgeInsets.all(8),
//       decoration: avatarDecoration,
//       child: Container(
//         decoration: avatarDecoration,
//         padding: EdgeInsets.all(3),
//         child: Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             image: DecorationImage(
//               image: AssetImage('assets/images/user.png'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SocialIcons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         SocialIcon(
//           color: Color(0xFF102397),
//           iconData: facebook,
//           onPressed: () {},
//         ),
//         SocialIcon(
//           color: Color(0xFFff4f38),
//           iconData: googlePlus,
//           onPressed: () {},
//         ),
//         SocialIcon(
//           color: Color(0xFF38A1F3),
//           iconData: twitter,
//           onPressed: () {},
//         ),
//         SocialIcon(
//           color: Color(0xFF2867B2),
//           iconData: linkedin,
//           onPressed: () {},
//         )
//       ],
//     );
//   }
// }

// class SocialIcon extends StatelessWidget {
//   final Color color;
//   final IconData iconData;
//   final Function onPressed;
//
//   SocialIcon({this.color, this.iconData, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return new Padding(
//       padding: EdgeInsets.only(left: 20.0),
//       child: Container(
//         width: 45.0,
//         height: 45.0,
//         decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//         child: RawMaterialButton(
//           shape: CircleBorder(),
//           onPressed: onPressed,
//           child: Icon(iconData, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          ProfileListItem(
            icon: Icons.history,
            text: 'Purchase History',
          ),

          ProfileListItem(
            icon: Icons.help_rounded,
            text: 'Help & Support',
          ),
          // ProfileListItem(
          //   icon: Icons.settings,
          //   text: 'Settings',
          // ),
          ProfileListItem(
            icon: Icons.message,
            text: 'Invite a Friend',
          ),
          ProfileListItem(
            icon: Icons.privacy_tip_rounded,
            text: 'Privacy',
          ),
          ProfileListItem(
            icon: Icons.logout_rounded,
            text: 'Logout',
            hasNavigation: false,
          ),
        ],
      ),
    );
  }
}
