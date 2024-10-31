import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/widgets/Logo.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:provider/provider.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(bool)? callback; // Optional callback
  final bool automaticallyImplyLeading;
  const GlobalAppBar(
      {Key? key, this.callback, this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      if (callback != null) {
        callback!(true);
      }
      Future.delayed(const Duration(seconds: 2), () => {});

      // Use AuthProvider to perform the login
      try {
        // Fetch AuthProvider instance
        var authProvider = Provider.of<AuthProvider>(context, listen: false);

        await authProvider.signOut();
        debugPrint(authProvider.getToken());

        if (callback != null) {
          callback!(false);
        }

        // Check if authenticated to navigate or show success message
        if (!authProvider.isAuthenticated) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Logout Successful!')));
          NavigationService.navigateToLoginPage();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Logout Failed')));
        }
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout Failed: $e')));
      }
    }

    Future<void> _testCallback() async {
      if (callback != null) {
        callback!(true);
      }
      Future.delayed(
          const Duration(seconds: 2),
          () => {
                if (callback != null) {callback!(false)}
              });
    }

    return (automaticallyImplyLeading)
        ? AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: AppColors.backgroundColor,
            iconTheme: const IconThemeData(color: AppColors.textColor),
            elevation: 1,
            title: const Logo(),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                color: AppColors.textColor,
                onPressed: _logout,
              ),
            ],
          )
        : AppBar(
            automaticallyImplyLeading: false,
            leading: const BackButton(),
            backgroundColor: AppColors.backgroundColor,
            iconTheme: const IconThemeData(color: AppColors.textColor),
            elevation: 1,
            title: const Logo(),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                color: AppColors.textColor,
                onPressed: _logout,
              ),
            ],
          );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
