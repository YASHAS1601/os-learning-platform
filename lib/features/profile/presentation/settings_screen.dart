import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/glass_container.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/services/supabase_service.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onOpenDrawer;

  const SettingsScreen({
    super.key,
    this.onOpenDrawer,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  final String _selectedLanguage = "English";

  Future<void> _handleSignOut() async {
    final service = SupabaseService.instance;
    await service.signOut();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AppColors.isDark(context);
    final accentBlue = isDark ? AppColors.neonBlue : AppColors.iconPrimaryLight;
    final accentCyan = isDark ? AppColors.neonCyan : AppColors.iconPrimaryLight;
    final accentPurple = isDark ? AppColors.neonPurple : AppColors.iconActiveLight;

    final service = SupabaseService.instance;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title with Hamburger Icon
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu_rounded, color: accentPurple, size: 28),
                    onPressed: () {
                      if (widget.onOpenDrawer != null) {
                        widget.onOpenDrawer!();
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text1(context),
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SectionHeader(
                title: "App Preferences",
                subtitle: "Customize your theme, notifications, and account options",
                accentColor: accentPurple,
              ),

              const SizedBox(height: 12),

              GlassContainer(
                padding: const EdgeInsets.symmetric(vertical: 4),
                borderColor: accentPurple.withAlpha(isDark ? 40 : 30),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: ThemeController.instance.isDarkMode,
                      onChanged: (val) {
                        setState(() {
                          ThemeController.instance.toggleTheme(val);
                        });
                      },
                      activeThumbColor: accentCyan,
                      secondary: Icon(
                        ThemeController.instance.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: accentCyan,
                      ),
                      title: Text(
                        "Dark Synthwave Mode",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.text1(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        ThemeController.instance.isDarkMode ? "Futuristic dark synthwave visual theme" : "Modern soft-glass light visual theme",
                        style: TextStyle(fontSize: 11, color: AppColors.textM(context)),
                      ),
                    ),
                    Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),
                    SwitchListTile(
                      value: _notificationsEnabled,
                      onChanged: (val) => setState(() => _notificationsEnabled = val),
                      activeThumbColor: accentCyan,
                      secondary: Icon(Icons.notifications_rounded, color: accentCyan),
                      title: Text(
                        "Daily Reminders",
                        style: TextStyle(fontSize: 14, color: AppColors.text1(context), fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Notifications for study streak",
                        style: TextStyle(fontSize: 11, color: AppColors.textM(context)),
                      ),
                    ),
                    Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),
                    ListTile(
                      leading: Icon(Icons.language_rounded, color: accentPurple),
                      title: Text(
                        "Language",
                        style: TextStyle(fontSize: 14, color: AppColors.text1(context), fontWeight: FontWeight.w600),
                      ),
                      trailing: Text(
                        _selectedLanguage,
                        style: TextStyle(fontSize: 13, color: accentPurple, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Language set to English."),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),
                    ListTile(
                      leading: Icon(
                        service.isAuthenticated ? Icons.logout_rounded : Icons.login_rounded,
                        color: service.isAuthenticated ? Colors.redAccent : accentBlue,
                      ),
                      title: Text(
                        service.isAuthenticated ? "Sign Out" : "Sign In / Switch Account",
                        style: TextStyle(
                          fontSize: 14,
                          color: service.isAuthenticated ? Colors.redAccent : AppColors.text1(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        service.isAuthenticated ? "Sign out of your Supabase account" : "Sign in to sync your study progress",
                        style: TextStyle(fontSize: 11, color: AppColors.textM(context)),
                      ),
                      onTap: () {
                        if (service.isAuthenticated) {
                          _handleSignOut();
                        } else {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                    ),
                    Divider(height: 1, color: isDark ? AppColors.glassBorder : const Color(0xFFE2E8F0)),
                    ListTile(
                      leading: Icon(Icons.info_outline_rounded, color: accentBlue),
                      title: Text(
                        "About OS Learning Platform",
                        style: TextStyle(fontSize: 14, color: AppColors.text1(context), fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "v1.0.0 • Mobile-first Operating Systems App",
                        style: TextStyle(fontSize: 11, color: AppColors.textM(context)),
                      ),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: "OS Learning Platform",
                          applicationVersion: "1.0.0",
                          applicationLegalese: "© 2026 OS Learning Platform. Built for Operating Systems Students.",
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
