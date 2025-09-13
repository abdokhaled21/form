import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup_background_widget.dart';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? fullNameError;
  String? phoneError;
  String? termsError;

  void _submit() {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      fullNameError = null;
      phoneError = null;
      termsError = null;
    });

    bool valid = true;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final fullName = _fullNameController.text.trim();
    final phone = _phoneController.text.trim();

    // Email validation
    if (email.isEmpty) {
      emailError = 'Email is required';
      valid = false;
    } else {
      final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emailError = 'Please enter a valid email address';
        valid = false;
      }
    }

    // Password validation
    if (password.isEmpty) {
      passwordError = 'Password is required';
      valid = false;
    } else {
      final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$');
      if (!passwordRegex.hasMatch(password)) {
        passwordError = 'Password must contain at least 1 uppercase, 1 lowercase, 1 number, 1 special character and be at least 6 characters';
        valid = false;
      }
    }

    // Confirm password validation
    if (confirmPassword.isEmpty) {
      confirmPasswordError = 'Please confirm your password';
      valid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError = 'Passwords do not match';
      valid = false;
    }

    // Full name validation
    if (fullName.isEmpty) {
      fullNameError = 'Full name is required';
      valid = false;
    }

    // Phone validation
    if (phone.isEmpty) {
      phoneError = 'Phone number is required';
      valid = false;
    }

    // Terms validation
    if (!_acceptTerms) {
      termsError = 'You must accept the terms and conditions';
      valid = false;
    }

    setState(() {});

    if (valid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show the first error as a SnackBar for better visibility
      String? mainError = emailError ?? passwordError ?? confirmPasswordError ?? fullNameError ?? phoneError ?? termsError;
      if (mainError != null) {
        showTopErrorBar(context, mainError);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all required fields correctly.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void showTopErrorBar(BuildContext context, String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 4),
      backgroundColor: Colors.redAccent.shade700,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      borderRadius: BorderRadius.circular(12),
      flushbarPosition: FlushbarPosition.TOP,
      icon: const Icon(Icons.error_outline, color: Colors.white, size: 28),
      leftBarIndicatorColor: Colors.white,
      messageColor: Colors.white,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.22),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ],
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    ).show(context);
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? error,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: 62,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: error != null ? Colors.redAccent : Colors.white.withOpacity(0.15),
              width: error != null ? 2 : 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white60, size: 24),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: toggleVisibility != null
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.white.withOpacity(0.5),
                        size: 24,
                      ),
                      onPressed: toggleVisibility,
                    )
                  : null,
            ),
            onChanged: onChanged,
          ),
        ),
        // No inline error message, errors are now shown as SnackBar
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background shapes
          const SignUpBackgroundWidget(),
          // Foreground content (form, etc)
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    // Create Account Title
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    const Text(
                      'Sign up to get started',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email Field
                          _buildInputField(
                            controller: _emailController,
                            hintText: 'Email Address',
                            icon: Icons.email_outlined,
                            error: emailError,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (_) {
                              if (emailError != null) setState(() => emailError = null);
                            },
                          ),
                          const SizedBox(height: 28),
                          // Password Field
                          _buildInputField(
                            controller: _passwordController,
                            hintText: 'Password',
                            icon: Icons.lock_outline,
                            error: passwordError,
                            obscureText: _obscurePassword,
                            toggleVisibility: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            onChanged: (_) {
                              if (passwordError != null) setState(() => passwordError = null);
                            },
                          ),
                          const SizedBox(height: 28),
                          // Confirm Password Field
                          _buildInputField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            icon: Icons.lock_outline,
                            error: confirmPasswordError,
                            obscureText: _obscureConfirmPassword,
                            toggleVisibility: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                            onChanged: (_) {
                              if (confirmPasswordError != null) setState(() => confirmPasswordError = null);
                            },
                          ),
                          const SizedBox(height: 28),
                          // Full Name Field
                          _buildInputField(
                            controller: _fullNameController,
                            hintText: 'Full Name',
                            icon: Icons.person_outline,
                            error: fullNameError,
                            keyboardType: TextInputType.name,
                            onChanged: (_) {
                              if (fullNameError != null) setState(() => fullNameError = null);
                            },
                          ),
                          const SizedBox(height: 28),
                          // Phone Number Field
                          _buildInputField(
                            controller: _phoneController,
                            hintText: 'Phone Number',
                            icon: Icons.phone_outlined,
                            error: phoneError,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            onChanged: (_) {
                              if (phoneError != null) setState(() => phoneError = null);
                            },
                          ),
                          const SizedBox(height: 20),
                          // Terms and Conditions Checkbox
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                  value: _acceptTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _acceptTerms = value ?? false;
                                      if (_acceptTerms && termsError != null) {
                                        termsError = null;
                                      }
                                    });
                                  },
                                  activeColor: Colors.white,
                                  checkColor: const Color(0xFF36399D),
                                  side: BorderSide(
                                    color: termsError != null ? Colors.redAccent : Colors.white.withOpacity(0.6),
                                    width: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _acceptTerms = !_acceptTerms;
                                      if (_acceptTerms && termsError != null) {
                                        termsError = null;
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      'I accept the Terms and Conditions',
                                      style: TextStyle(
                                        color: termsError != null ? Colors.redAccent : Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (termsError != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline, color: Colors.redAccent.withOpacity(0.85), size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    termsError!,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 30),
                          // Sign Up Button - copied exactly from login screen
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Container(
                                height: 62,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF9500B1).withOpacity(0.55),
                                      const Color(0xFF3B82F6).withOpacity(0.55),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  border: Border.all(color: Colors.white.withOpacity(0.35), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF8B5CF6).withOpacity(0.18),
                                      blurRadius: 20,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: _submit,
                                    child: const Center(
                                      child: Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Log In link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
