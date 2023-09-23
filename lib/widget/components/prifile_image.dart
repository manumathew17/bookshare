import 'package:bookshare/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditableImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback onImageClicked;

  const EditableImage({
    required this.imageUrl,
    required this.onImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageClicked,
      child: Stack(
        children: [
          SizedBox(
            width: 15.w,
            height: 15.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.w / 2),
              child: Image.network(
                imageUrl,
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
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  // Return a default image widget when the network image fails to load
                  return Image.asset(
                    'assets/icons/add-photo.png', // Replace with the path to your default image asset
                    fit: BoxFit.contain,
                    color: yellowPrimary,
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onImageClicked, // Call the function when the image or edit icon is clicked
              child: Icon(
                Icons.camera_enhance_rounded, // You can change this to your preferred edit icon
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
