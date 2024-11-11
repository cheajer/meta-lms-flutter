import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_lms/provider/AuthProvider.dart';
import 'package:meta_lms/services/NavigationService.dart';
import 'package:meta_lms/ui/widgets/ListButton.dart';
import 'package:meta_lms/ui/widgets/LoadingScreen.dart';
import 'package:meta_lms/ui/widgets/NamedBoxButton.dart';
import 'package:provider/provider.dart';
import 'package:meta_lms/utils/AppColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<AuthProvider>(context, listen: false).loadToken();
      // Now it's safe to call Provider.of because build context is fully established
      var authProvider = Provider.of<AuthProvider>(context, listen: false);
      bool isAuthenticated =
          authProvider.checkAuthentication(); // Properly await the Future

      // This debugPrint statement needs to be inside the microtask
      debugPrint(isAuthenticated ? 'y' : 'n');
      if (isAuthenticated) {
        // Make sure to perform UI-related calls in the proper context
        // Since we're inside a callback, use the context from the callback's scope
        NavigationService.navigateToHomePage();
      }

      _usernameController.text = "cheajer";
      _passwordController.text = "b4b26php9125";
      
    });
  }

  Future<void> _login() async {
    // Use AuthProvider to perform the login
    setState(() {
      _isLoading = true;
    });
    try {
      // Fetch AuthProvider instance
      var authProvider = Provider.of<AuthProvider>(context, listen: false);

      await authProvider.signIn(
          _usernameController.text, _passwordController.text);
      debugPrint(authProvider.getToken());
      setState(() {
        _isLoading = false;
      });
      // Check if authenticated to navigate or show success message
      if (authProvider.isAuthenticated) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Successful!')));
        // Optionally navigate to another page
        NavigationService.navigateToHomePage();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login Failed')));
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed: $e')));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (_isLoading)?LoadingScreen():SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 100,
              ), // Ensure you have this SVG in your assets
              const SizedBox(height: 30),
              Text(
                'MetaLMS',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'User Name*',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password*',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              NamedBoxButton(
                text: 'Login',
                icon: Icons.login,
                onPressed: _login,
                height: 50,
              ),
              const SizedBox(height: 8),
              ListButton(
                text: 'Don\' have an account yet?.',
                icon: Icons.add,
                onPressed: () {},
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
