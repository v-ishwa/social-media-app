import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media_app/features/home/presentation/widgets/app_drawer_tile.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Divider(color: Theme.of(context).colorScheme.secondary),
            AppDrawerTile(
              title: 'H O M E',
              icon: Icons.home,
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                // Navigate to home page
              },
            ),
            AppDrawerTile(
              title: 'P R O F I L E',
              icon: Icons.person,
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                // Navigate to profile page
              },
            ),
            AppDrawerTile(
              title: 'S E A R C H',
              icon: Icons.search,
              onTap: () {
                // Navigate to search page
              },
            ),
            AppDrawerTile(
              title: 'S E T T I N G S',
              icon: Icons.settings,
              onTap: () {
                // Navigate to settings page
              },
            ),
            const Spacer(),
            AppDrawerTile(
              title: 'L O G O U T',
              icon: Icons.logout,
              onTap: () {
                context.read<AuthCubit>().logout();
                // Logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
