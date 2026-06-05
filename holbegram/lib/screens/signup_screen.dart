import 'package:flutter/material.dart';
import 'package:holbegram/screens/auth/methods/upload_image_screen.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:holbegram/widgets/text_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    this.emailController,
    this.usernameController,
    this.passwordController,
    this.passwordConfirmController,
    this.passwordVisible = true,
  });

  final TextEditingController? emailController;
  final TextEditingController? usernameController;
  final TextEditingController? passwordController;
  final TextEditingController? passwordConfirmController;
  final bool passwordVisible;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late bool _passwordVisible;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmController;
  late final bool _ownsEmailController;
  late final bool _ownsUsernameController;
  late final bool _ownsPasswordController;
  late final bool _ownsPasswordConfirmController;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.passwordVisible;
    _ownsEmailController = widget.emailController == null;
    _ownsUsernameController = widget.usernameController == null;
    _ownsPasswordController = widget.passwordController == null;
    _ownsPasswordConfirmController = widget.passwordConfirmController == null;
    _emailController = widget.emailController ?? TextEditingController();
    _usernameController = widget.usernameController ?? TextEditingController();
    _passwordController = widget.passwordController ?? TextEditingController();
    _passwordConfirmController =
        widget.passwordConfirmController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (_ownsEmailController) {
      _emailController.dispose();
    }
    if (_ownsUsernameController) {
      _usernameController.dispose();
    }
    if (_ownsPasswordController) {
      _passwordController.dispose();
    }
    if (_ownsPasswordConfirmController) {
      _passwordConfirmController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 28),
            const Text(
              'Holbegram',
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 50,
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  TextFieldInput(
                    controller: _emailController,
                    isPassword: false,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: _usernameController,
                    isPassword: false,
                    hintText: 'Username',
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: _passwordController,
                    isPassword: !_passwordVisible,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldInput(
                    controller: _passwordConfirmController,
                    isPassword: !_passwordVisible,
                    hintText: 'Confirm password',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(218, 226, 37, 24),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddPicture(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(218, 226, 37, 24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}