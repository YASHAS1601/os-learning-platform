import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/animated_network_background.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/neon_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUpMode = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final service = SupabaseService.instance;
        if (!service.isInitialized) {
          // Demo fallback when Supabase keys are not configured yet
          await Future.delayed(const Duration(milliseconds: 600));
          if (mounted) {
            Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
          }
          return;
        }

        await service.signInWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        if (mounted && service.isAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '').replaceAll('AuthApiException: ', '')),
              backgroundColor: Colors.redAccent.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        final service = SupabaseService.instance;
        if (!service.isInitialized) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please configure Supabase URL & Key in environment first."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          return;
        }

        final res = await service.signUpWithEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          name: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : null,
        );

        if (mounted) {
          if (res.user != null) {
            if (service.isAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account created successfully! Welcome!"),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account created! Please check your email to confirm your account, then Sign In."),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 4),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              setState(() {
                _isSignUpMode = false;
              });
            }
          }
        }
      } catch (e) {
        if (mounted) {
          final rawErr = e.toString().replaceAll('Exception: ', '').replaceAll('AuthApiException: ', '');
          String userFriendlyMsg = rawErr;
          final lower = rawErr.toLowerCase();
          if (lower.contains('already registered') || lower.contains('user_already_exists')) {
            userFriendlyMsg = "This email is already registered. Please Sign In instead.";
          } else if (lower.contains('rate limit') || lower.contains('over_email_send_rate_limit')) {
            userFriendlyMsg = "Email rate limit exceeded. Please wait a minute before trying again.";
          } else if (lower.contains('email_address_invalid') || lower.contains('invalid email')) {
            userFriendlyMsg = "Please enter a valid email address.";
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(userFriendlyMsg),
              backgroundColor: Colors.redAccent.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final service = SupabaseService.instance;
      if (!service.isInitialized) {
        // Fallback for UI preview when keys not set
        await Future.delayed(const Duration(milliseconds: 600));
        if (mounted) {
          Navigator.pushReplacementNamed(context, AppRoutes.mainNavigation);
        }
        return;
      }

      await service.signInWithGoogle();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Google sign in: ${e.toString().replaceAll('Exception: ', '')}"),
            backgroundColor: Colors.redAccent.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final themeColor = isDark ? AppColors.darkAccentBlue : AppColors.iconPrimaryLight;

    return Container(
      decoration: AppColors.bgDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedNetworkBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top App Logo Badge
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: themeColor.withAlpha(isDark ? 35 : 25),
                        border: Border.all(color: themeColor, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withAlpha(isDark ? 80 : 30),
                            blurRadius: 16,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.auto_stories_rounded,
                        color: themeColor,
                        size: 28,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title & Subtitle
                    Text(
                      _isSignUpMode ? "Create an Account" : "Welcome back",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isSignUpMode
                          ? "Join the OS Learning Platform today."
                          : "Continue your learning journey.",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.text2(context),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Floating Frosted Glass Login Card
                    GlassContainer(
                      padding: const EdgeInsets.all(24),
                      borderRadius: 24,
                      blur: 24.0,
                      borderColor: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_isSignUpMode) ...[
                              Text(
                                "Full Name",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text1(context),
                                ),
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: _nameController,
                                style: TextStyle(color: AppColors.text1(context), fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: "Yashas Kiran",
                                  hintStyle: TextStyle(color: AppColors.textM(context), fontSize: 14),
                                  prefixIcon: Icon(Icons.person_outline_rounded, color: themeColor, size: 20),
                                  filled: true,
                                  fillColor: isDark ? const Color(0x6614273C) : const Color(0x8CFFFFFF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide(color: themeColor, width: 1.5),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                ),
                                validator: (val) {
                                  if (_isSignUpMode && (val == null || val.trim().isEmpty)) {
                                    return "Please enter your name";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Email Input Field
                            Text(
                              "Email Address",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: AppColors.text1(context), fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "student@university.edu",
                                hintStyle: TextStyle(color: AppColors.textM(context), fontSize: 14),
                                prefixIcon: Icon(Icons.email_outlined, color: themeColor, size: 20),
                                filled: true,
                                fillColor: isDark ? const Color(0x6614273C) : const Color(0x8CFFFFFF),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: themeColor, width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) return "Please enter your email";
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Password Input Field
                            Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text1(context),
                              ),
                            ),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              style: TextStyle(color: AppColors.text1(context), fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "••••••••••••",
                                hintStyle: TextStyle(color: AppColors.textM(context), fontSize: 14),
                                prefixIcon: Icon(Icons.lock_outline_rounded, color: themeColor, size: 20),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                    color: AppColors.textM(context),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                filled: true,
                                fillColor: isDark ? const Color(0x6614273C) : const Color(0x8CFFFFFF),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: isDark ? const Color(0x24FFFFFF) : const Color(0x99FFFFFF)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide(color: themeColor, width: 1.5),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) return "Please enter your password";
                                if (_isSignUpMode && val.length < 6) return "Password must be at least 6 characters";
                                return null;
                              },
                            ),

                            if (!_isSignUpMode) ...[
                              // Forgot Password Link
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Password reset instructions sent to email."),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: themeColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],

                            const SizedBox(height: 16),

                            // Main Action Button (Sign In / Sign Up)
                            NeonButton(
                              text: _isLoading
                                  ? (_isSignUpMode ? "Creating account..." : "Signing in...")
                                  : (_isSignUpMode ? "Create Account" : "Sign In"),
                              icon: Icons.arrow_forward_rounded,
                              glowColor: themeColor,
                              onPressed: _isSignUpMode ? _handleSignUp : _handleSignIn,
                            ),

                            const SizedBox(height: 20),

                            // Divider with "OR"
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: isDark ? const Color(0x24FFFFFF) : const Color(0xFFE2E8F0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textM(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: isDark ? const Color(0x24FFFFFF) : const Color(0xFFE2E8F0),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Continue with Google Official Button
                            OutlinedButton(
                              onPressed: _handleGoogleSignIn,
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                                backgroundColor: isDark ? const Color(0x3314273C) : Colors.white,
                                side: BorderSide(
                                  color: isDark ? const Color(0x3D5EA8FF) : const Color(0xFFCBD5E1),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildGoogleLogo(),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                      color: AppColors.text1(context),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign Up / Sign In Toggle Link Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isSignUpMode ? "Already have an account? " : "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text2(context),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSignUpMode = !_isSignUpMode;
                            });
                          },
                          child: Text(
                            _isSignUpMode ? "Sign In" : "Sign Up",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: themeColor,
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
        ),
      ),
    );
  }

  // Official Multi-Color Google G Logo
  Widget _buildGoogleLogo() {
    return SizedBox(
      width: 18,
      height: 18,
      child: CustomPaint(
        painter: _GoogleLogoPainter(),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Offset center = Offset(w / 2, h / 2);
    final double radius = w / 2;

    final Paint redPaint = Paint()..color = const Color(0xFFEA4335);
    final Paint yellowPaint = Paint()..color = const Color(0xFFFBBC05);
    final Paint greenPaint = Paint()..color = const Color(0xFF34A853);
    final Paint bluePaint = Paint()..color = const Color(0xFF4285F4);

    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    // Red arc (top left to top right)
    canvas.drawArc(rect, 3.6, 1.9, true, redPaint);

    // Yellow arc (bottom left)
    canvas.drawArc(rect, 2.35, 1.25, true, yellowPaint);

    // Green arc (bottom right)
    canvas.drawArc(rect, 0.75, 1.6, true, greenPaint);

    // Blue arc & bar (right)
    canvas.drawArc(rect, -0.45, 1.2, true, bluePaint);

    // Cutout center
    final Paint whitePaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, radius * 0.55, whitePaint);

    // Blue horizontal arm
    final Rect armRect = Rect.fromLTRB(center.dx - 1, center.dy - radius * 0.22, w, center.dy + radius * 0.22);
    canvas.drawRect(armRect, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
