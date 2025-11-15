// LoginPage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rpgirl2/config/auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onSignUpPressed;

  const LoginPage({
    super.key, 
    required this.onSignUpPressed,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.login(_emailController.text, _passwordController.text);
      
      if (!mounted) return;
      
      // Navigate directly to home on successful login
      Navigator.pushNamedAndRemoveUntil(
        context, 
        '/home', 
        (route) => false
      );
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _togglePasswordVisibility() {
    if (mounted) {
      setState(() {
        _obscurePassword = !_obscurePassword;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage("lib/assets/images/default.png"),
                        height: 240,
                        width: 240,
                        fit: BoxFit.contain,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 8),
                        child: TextField(
                          controller: _emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor: Color(0xfff2f2f3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          filled: true,
                          fillColor: Color(0xfff2f2f3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility : Icons.visibility_off,
                              color: Color(0xff97989a),
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 16),
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : MaterialButton(
                                onPressed: _login,
                                color: Color(0x66ffffff),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                padding: EdgeInsets.all(16),
                                textColor: Color(0xffffffff),
                                height: 50,
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text("LOGIN"),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Color(0xffe2dcdc),
                            ),
                          ),
                          TextButton(
                            onPressed: widget.onSignUpPressed,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}