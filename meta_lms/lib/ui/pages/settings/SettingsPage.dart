import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meta_lms/ui/widgets/GlobalAppBar.dart';
import 'package:meta_lms/utils/LocaleProvider.dart';
import 'package:meta_lms/utils/ThemeNotifier.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    final isDarkMode = themeNotifier.isDarkMode;

    selectedLanguage = (localeProvider.locale.languageCode == "en")?"English":"中文";

    return Scaffold(
      appBar: GlobalAppBar(
        elevation: 1,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          // Account Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.account ?? "Account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading: Icon(Icons.account_circle,
                color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.profile ?? 'Profile'),
            subtitle: Text(AppLocalizations.of(context)?.editProfile ??
                'Edit your profile'),
            onTap: _navigateToProfile,
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading: Icon(Icons.lock, color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.changePassword ??
                'Change Password'),
            onTap: _navigateToChangePassword,
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading:
                Icon(Icons.logout, color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.logout ?? 'Logout'),
            onTap: _logout,
          ),
          const Divider(),

          // General Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.general ?? 'General',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          SwitchListTile(
            tileColor: Theme.of(context).cardColor,
            value: isDarkMode,
            onChanged: (value) {
              themeNotifier.toggleTheme(value);
            },
            secondary:
                Icon(Icons.dark_mode, color: Theme.of(context).primaryColor),
            title: Text(
              AppLocalizations.of(context)?.darkMode ?? 'Dark Mode',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading:
                Icon(Icons.language, color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.language ?? 'Language'),
            subtitle: Text(selectedLanguage),
            onTap: () => _showLanguageSelection(context, localeProvider),
          ),
          const Divider(),

          // Notifications Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.notifications ?? 'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          SwitchListTile(
            tileColor: Theme.of(context).cardColor,
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications,
                color: Theme.of(context).primaryColor),
            title: Text(
              AppLocalizations.of(context)?.enableNotifications ??
                  'Enable Notifications',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading:
                Icon(Icons.email, color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.emailNotifications ??
                'Email Notifications'),
          ),
          const Divider(),

          // Privacy & Security Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.privacySecurity ??
                  'Privacy & Security',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading: Icon(Icons.privacy_tip,
                color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.privacyPolicy ??
                'Privacy Policy'),
          ),
          ListTile(
            tileColor: Theme.of(context).cardColor,
            leading:
                Icon(Icons.security, color: Theme.of(context).primaryColor),
            title: Text(AppLocalizations.of(context)?.termsConditions ??
                'Terms & Conditions'),
          ),
        ],
      ),
    );
  }

  // Navigation and Action Methods
  void _navigateToProfile() {
    print("Navigating to Profile Page");
  }

  void _navigateToChangePassword() {
    print("Navigating to Change Password Page");
  }

  void _logout() {
    print("Logging out");
  }

  // Method to show language selection dialog
  void _showLanguageSelection(
      BuildContext context, LocaleProvider localeProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.selectLanguage ??'Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Spanish', 'French', 'German', '中文']
                .map((language) => RadioListTile(
                      title: Text(language),
                      value: language,
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value.toString();
                        });

                        if (value.toString() == 'English') {
                          localeProvider.setLocale(Locale('en'));
                        }

                        if (value.toString() == '中文') {
                          localeProvider.setLocale(Locale('zh'));
                        }

                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
