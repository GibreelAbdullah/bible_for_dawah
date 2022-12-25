import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share/share.dart';

class CommonDrawer extends StatelessWidget {
  final String currentScreen;

  const CommonDrawer({Key? key, required this.currentScreen}) : super(key: key);

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  DrawerItem(
                    currentScreen: currentScreen,
                    title: homeScreenTitle,
                    route: '/home',
                    icon: Icons.search,
                  ),
                  DrawerItem(
                    currentScreen: currentScreen,
                    title: databaseTitle,
                    route: '/datastore',
                    icon: Icons.list,
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(),
                  DrawerItem(
                      currentScreen: currentScreen,
                      title: moreApps,
                      route: '/moreapps',
                      icon: Icons.more_horiz),
                  DrawerItem(
                      currentScreen: currentScreen,
                      title: donateScreenTitle,
                      route: '/donate',
                      icon: Icons.payment),
                  DrawerItem(
                      currentScreen: currentScreen,
                      title: settingsScreenTitle,
                      route: '/settings',
                      icon: Icons.settings),
                  DrawerItem(
                    currentScreen: currentScreen,
                    title: aboutAppScreenTitle,
                    route: '/aboutus',
                    icon: Icons.people,
                  ),
                  // const RateUs(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class RateUs extends StatelessWidget {
//   const RateUs({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: TextButton(
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.star,
//                   color: Theme.of(context).iconTheme.color,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   "Rate Us",
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ],
//             ),
//             onPressed: () {
//               launch(HANS_WEHR_ANDROID_LINK);
//             },
//           ),
//         ),
//         TextButton(
//           child: Icon(
//             Icons.share,
//             color: Theme.of(context).iconTheme.color,
//           ),
//           onPressed: () {
//             Share.share('Check out this Hans Wehr Dictionary App : ' +
//                 HANS_WEHR_ANDROID_LINK);
//           },
//         ),
//       ],
//     );
//   }
// }

class DrawerItem extends StatelessWidget {
  final String currentScreen;
  final String title;
  final String route;
  final IconData icon;
  const DrawerItem({
    Key? key,
    required this.currentScreen,
    required this.title,
    required this.route,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (currentScreen != title) {
          if (currentScreen == homeScreenTitle) {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
          }
        } else {
          Navigator.pop(context);
        }
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
