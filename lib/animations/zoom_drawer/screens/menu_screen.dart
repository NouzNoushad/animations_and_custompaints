import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/page_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key, required this.drawerEnd});
  final double drawerEnd;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Color backgroundColor = const Color.fromARGB(255, 33, 1, 94);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: widget.drawerEnd,
            color: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(20),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.read<PageProvider>().changePageScreen(0),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Favorite",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.read<PageProvider>().changePageScreen(1),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.read<PageProvider>().changePageScreen(2),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => context.read<PageProvider>().changePageScreen(3),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Exit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
