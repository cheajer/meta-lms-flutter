import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/utils/AppColors.dart';
import 'package:provider/provider.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(bool)? callback; // Optional callback
  const GlobalAppBar({Key? key, this.callback}) : super(key: key);

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

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 1,
      title: Row(children: [
        IconButton(
          color: AppColors.textColor,
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {
            _testCallback();
          },
        ),
        const Spacer(),
        SvgPicture.asset('assets/icons/mark.svg', width: 40),
        const Spacer(),
        IconButton(
          color: AppColors.textColor,
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            // Add your logout button press logic here
            _logout();
          },
        ),
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
