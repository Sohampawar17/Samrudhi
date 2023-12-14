import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../constants.dart';
import '../router.router.dart';

Widget myDrawer(BuildContext context, String name, String email, String image) {
  return Drawer(
    child: SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.blue, // Change the background color as needed
            padding: const EdgeInsets.only(top: 20),
            child: UserAccountsDrawerHeader(
              accountName: AutoSizeText(
                name,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust text color
                ),
              ),
              accountEmail: AutoSizeText(
                email,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white, // Adjust text color
                ),
              ),
              arrowColor: Colors.black87,
              currentAccountPicture: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white, // Set background color for the avatar
                backgroundImage: NetworkImage(image),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    'https://babich.biz/content/images/2016/03/user-profile-bg.jpg',
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Bootstrap.house, color: Colors.black),
            title: const Text(
              'Home',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.homePage);
            },
          ),
          ListTile(
            leading: const Icon(FontAwesome.location_arrow, color: Colors.black),
            title: const Text(
              'Geolocation',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, Routes.geolocation);
            },
          ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Iconsax.logout, color: Colors.black),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Logout'),
                    content: Text('Are you sure you want to log out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          logout(context); // Close the dialog
                        },
                        child: Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
