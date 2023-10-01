import 'dart:io';

import 'package:bookshare/config/account.dart';
import 'package:bookshare/network/callback.dart';
import 'package:bookshare/network/request_route.dart';
import 'package:bookshare/provider/auth/auth_provider.dart';
import 'package:bookshare/theme/colors.dart';
import 'package:bookshare/utils/Logger.dart';
import 'package:bookshare/widget/components/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_style.dart';
import '../../../widget/components/prifile_image.dart';
import '../../../widget/components/profile_list_items.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfileScreen> {
  RequestRouter requestRouter = RequestRouter();
  late GeneralSnackBar _generalSnackBar;

  @override
  void initState() {
    _generalSnackBar = GeneralSnackBar(context);
    requestRouter.getProfile(RequestCallbacks(onSuccess: (data) {}, onError: (error) {}));
    Logger.log(AccountConfig.userDetail.user.profile_image);
    super.initState();
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      final fileSize = await imageFile.length();

      if (fileSize <= 1024 * 1024) {
        requestRouter.uploadImage(
            pickedImage.path,
            RequestCallbacks(
                onSuccess: (response) {
                  _generalSnackBar.showSuccessSnackBar("Profile photo uploaded");
                  Provider.of<AuthProvider>(context, listen: false).getUserProfile();
                },
                onError: (error) {
                  _generalSnackBar.showErrorSnackBar("Failed to update the image");
                }));
      } else {
        _generalSnackBar.showErrorSnackBar("Please select the image which sizes is smaller than 1 MB");
      }
    }
  }

  editUser() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: EditProfile(
              userDetail: Provider.of<AuthProvider>(context, listen: false).userDetail,
              onUpdate: () => {
                Provider.of<AuthProvider>(context, listen: false).getUserProfile(),
                Navigator.pop(context),
                _generalSnackBar.showSuccessSnackBar("Successfully updated the profile")
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {


    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
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
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[200]!),
                          ),
                          onPressed: () {
                            editUser();
                          },
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                  ),
                  EditableImage(
                    imageUrl: requestRouter.url(AccountConfig.userDetail.user.profile_image),
                    onImageClicked: () => {_pickImage()},
                  ),
                  // SizedBox(
                  //   width: 15.w,
                  //   height: 15.w,
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(15.w / 2),
                  //     child: Image.network(
                  //       "https://imgv3.fotor.com/images/gallery/Realistic-Female-Profile-Picture.jpg",
                  //       fit: BoxFit.cover,
                  //       width: double.infinity,
                  //       height: double.infinity,
                  //       loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  //         if (loadingProgress == null) {
                  //           return child;
                  //         } else {
                  //           return const Center(
                  //             child: CircularProgressIndicator(
                  //               strokeWidth: 1,
                  //             ),
                  //           );
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),

                  // SocialIcons(),
                  SizedBox(height: 10),
                  Text(
                    authProvider.userDetail.user.name,
                    style: header.copyWith(color: Colors.black),
                  ),
                  Text(
                    authProvider.userDetail.user.email,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 5.h),
                  ProfileListItem(
                    icon: Icons.location_on_rounded,
                    text: authProvider.userDetail.user.address,
                    tailIcon: Icons.edit,
                    onClick: () => {editUser()},
                  ),
                  ProfileListItems(),
                ],
              ),
            )
          ],
        ),
      );
    });
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
            onClick: () => {},
          ),

          ProfileListItem(
            icon: Icons.help_rounded,
            text: 'Help & Support',
            onClick: () => {},
          ),
          // ProfileListItem(
          //   icon: Icons.settings,
          //   text: 'Settings',
          // ),
          ProfileListItem(
            icon: Icons.message,
            text: 'Invite a Friend',
            onClick: () => {},
          ),
          ProfileListItem(
            icon: Icons.privacy_tip_rounded,
            text: 'Privacy',
            onClick: () => {},
          ),
          ProfileListItem(
            icon: Icons.logout_rounded,
            text: 'Logout',
            onClick: () {
              Provider.of<AuthProvider>(context, listen: false).logOut();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
