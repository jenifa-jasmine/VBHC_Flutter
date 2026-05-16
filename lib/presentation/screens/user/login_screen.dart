// ============================================================
// lib/presentation/screens/user/login_screen.dart
// ✅ VBHCColors (Light/Dark auto switch)
// ✅ CustomDropdownPicker (Entity - Real API)
// ✅ Real API (getEntity + login + getUserModules)
// ✅ AuthCubit connect
// ✅ Animations (logo, card, button, shake)
// ✅ Captcha support (Environment.showCaptcha flag)
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/auth/auth_cubit.dart';
import '../../../bloc/auth/auth_state.dart';
import '../../../bloc/theme/theme_cubit.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/environment.dart';
import '../../../data/models/entity_model.dart';
import '../../widgets/pickers/customdropdown.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // ── Controllers ──────────────────────────────────────────
  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _captchaCtrl = TextEditingController();
  bool _showPassword = false;

  // ── Animation Controllers ────────────────────────────────
  late AnimationController _logoAnimCtrl;
  late AnimationController _cardAnimCtrl;
  late AnimationController _buttonAnimCtrl;
  late AnimationController _shakeAnimCtrl;

  late Animation<double> _logoOpacity;
  late Animation<double> _cardSlide;
  late Animation<double> _buttonScale;
  late Animation<double> _shakeAnim;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();

    // RN: useGetEntityQuery() + useGetCaptachaQuery()
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthCubit>().loadEntities();
      if (Environment.showCaptcha) {
        context.read<AuthCubit>().loadCaptcha();
      }
    });
  }

  void _setupAnimations() {
    _logoAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoAnimCtrl, curve: Curves.easeOut),
    );

    _cardAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _cardSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _cardAnimCtrl, curve: Curves.easeOutCubic),
    );

    _buttonAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _buttonScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _buttonAnimCtrl, curve: Curves.easeOut),
    );

    // Shake - captcha refresh
    _shakeAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8.0, end: 6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(_shakeAnimCtrl);
  }

  void _startAnimations() {
    _logoAnimCtrl.forward();
    _cardAnimCtrl.forward();
    _buttonAnimCtrl.forward();
  }

  @override
  void dispose() {
    _logoAnimCtrl.dispose();
    _cardAnimCtrl.dispose();
    _buttonAnimCtrl.dispose();
    _shakeAnimCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _captchaCtrl.dispose();
    super.dispose();
  }

  // ── Login ─────────────────────────────────────────────────
  // RN: handleLogin() → login().unwrap() → getUserModule()
  void _handleLogin() {
    context.read<AuthCubit>().login(
          username: _usernameCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
          captchaInput: _captchaCtrl.text.trim(),
        );
  }

  // ── Captcha Refresh ───────────────────────────────────────
  // RN: handleRefreshCaptcha() → triggerShake() → refreshCaptcha()
  void _handleRefreshCaptcha() {
    _captchaCtrl.clear();
    _shakeAnimCtrl.forward(from: 0);
    context.read<AuthCubit>().refreshCaptcha();
  }

  void _showMsg(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'OpenSans')),
        backgroundColor: isError ? AppColors.statusRed : AppColors.gold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ── BUILD ─────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = VBHCColors(isDark);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          _showMsg(state.error!, isError: true);
          if (Environment.showCaptcha) _handleRefreshCaptcha();
          context.read<AuthCubit>().clearError();
        }
        if (state.isLoggedIn) {
          _showMsg("Login successful ✅");
          // TODO: context.go('/main');
        }
      },
      builder: (context, authState) {
        return Scaffold(
          backgroundColor: colors.backgroundWhite,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(colors),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Column(
                        children: [
                          _buildCard(colors, authState, isDark),
                          const SizedBox(height: 12),
                          Text(
                            "${Environment.appVersion} | ${Environment.releaseDate}",
                            style: TextStyle(
                              color: colors.textGray,
                              fontSize: 12,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── HEADER ───────────────────────────────────────────────
  Widget _buildHeader(VBHCColors colors) {
    return FadeTransition(
      opacity: _logoOpacity,
      child: Container(
        height: 160,
        width: double.infinity,
        color: colors.backgroundWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Image.asset(
          'assets/images/vbhc_portrait.png',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Center(
            child: Text(
              "VBHC",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: AppColors.gold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── LOGIN CARD ───────────────────────────────────────────
  Widget _buildCard(
    VBHCColors colors,
    AuthState authState,
    bool isDark,
  ) {
    return AnimatedBuilder(
      animation: Listenable.merge([_cardAnimCtrl, _logoAnimCtrl]),
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _cardSlide.value),
        child: Opacity(opacity: _logoOpacity.value, child: child),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          color: colors.backgroundWhite,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.45)
                  : Colors.black.withValues(alpha: 0.10),
              offset: const Offset(0, 8),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome ──────────────────────────────────
            _buildWelcome(colors),
            const SizedBox(height: 18),

            // ── Trust Row ─────────────────────────────────
            _buildTrustRow(colors),
            const SizedBox(height: 18),

            // ── ENTITY DROPDOWN (Real API) ────────────────
            _buildEntityDropdown(colors, authState),
            const SizedBox(height: 14),

            // ── USERNAME ──────────────────────────────────
            _buildField(
              colors: colors,
              ctrl: _usernameCtrl,
              hint: "Username",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 14),

            // ── PASSWORD ──────────────────────────────────
            _buildField(
              colors: colors,
              ctrl: _passwordCtrl,
              hint: "Password",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 8),

            // ── CAPTCHA (DEV=false, SIT/UAT/PROD=true) ────
            if (Environment.showCaptcha) ...[
              _buildCaptcha(colors, authState),
              const SizedBox(height: 8),
            ],

            // ── FORGOT PASSWORD ───────────────────────────
            _buildForgotPassword(colors),
            const SizedBox(height: 10),

            // ── LOGIN BUTTON ──────────────────────────────
            _buildLoginButton(colors, authState),
            const SizedBox(height: 16),

            // Quote
            Center(
              child: Text(
                '"Security is not a product, but a process."',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: colors.textLabelColor,
                  fontFamily: 'OpenSans',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Welcome ───────────────────────────────────────────────
  Widget _buildWelcome(VBHCColors colors) {
    return Column(
      children: [
        Center(
          child: Text(
            "Welcome Back",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colors.textBlack,
                fontFamily: 'OpenSans'),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            "Sign in to access your secure VBHC workspace",
            style: TextStyle(
                fontSize: 13,
                color: colors.textLabelColor,
                fontFamily: 'OpenSans'),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // ── Trust Row ─────────────────────────────────────────────
  Widget _buildTrustRow(VBHCColors colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _trustItem(colors, Icons.shield_outlined, "Secure Login"),
        _trustItem(colors, Icons.lock_outline, "Encrypted Data"),
        _trustItem(colors, Icons.business_outlined, "Enterprise Ready"),
      ],
    );
  }

  Widget _trustItem(VBHCColors colors, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.gold),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colors.textLabelColor,
              fontFamily: 'OpenSans'),
        ),
      ],
    );
  }

  // ── ENTITY DROPDOWN ──────────────────────────────────────
  // RN: ModalDropdown → entities → dispatch(setSelectedEntity)
  Widget _buildEntityDropdown(VBHCColors colors, AuthState authState) {
    final items = authState.entities
        .map((e) => DropdownItem<EntityModel>(
              value: e,
              label: e.name ?? "",
              icon: Icons.business_outlined,
            ))
        .toList();

    return CustomDropdownPicker<EntityModel>(
      hint: "Select Entity",
      value: authState.selectedEntity,
      items: items,
      searchable: items.length > 5,
      clearable: false,
      disabled: authState.isEntityLoading,
      mode: DropdownMode.bottomSheet,
      theme: DropdownThemeData(
        primaryColor: AppColors.gold,
        borderColor: colors.borderColor,
        activeBorderColor: AppColors.gold,
        backgroundColor: colors.backgroundWhite,
        overlayColor: colors.backgroundWhite,
        selectedItemColor: AppColors.gold,
        hintColor: colors.textInputPlaceholder,
        borderRadius: 14,
        hintStyle: TextStyle(
          color: colors.textInputPlaceholder,
          fontFamily: 'OpenSans',
          fontSize: 15,
        ),
        itemStyle: TextStyle(
          color: colors.textBlack,
          fontFamily: 'OpenSans',
          fontSize: 15,
        ),
      ),
      prefixIcon: authState.isEntityLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.gold,
              ),
            )
          : Icon(Icons.business_outlined, color: colors.textGray, size: 20),
      onChanged: (entity) {
        if (entity != null) {
          // RN: dispatch(setSelectedEntity(entity))
          context.read<AuthCubit>().selectEntity(entity);
        }
      },
    );
  }

  // ── Input Field ───────────────────────────────────────────
  Widget _buildField({
    required VBHCColors colors,
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: colors.textInputBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.borderColor),
      ),
      child: TextField(
        controller: ctrl,
        obscureText: isPassword && !_showPassword,
        style: TextStyle(
          color: colors.textInputTextColor,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: colors.textInputPlaceholder,
            fontFamily: 'OpenSans',
          ),
          prefixIcon: Icon(icon, color: colors.textGray, size: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: colors.textGray,
                    size: 22,
                  ),
                  onPressed: () =>
                      setState(() => _showPassword = !_showPassword),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // ── CAPTCHA ───────────────────────────────────────────────
  // RN: captchaData?.captcha_image_url → Image + TextInput
  Widget _buildCaptcha(VBHCColors colors, AuthState authState) {
    return Column(
      children: [
        // Captcha image row with shake animation
        AnimatedBuilder(
          animation: _shakeAnim,
          builder: (_, child) => Transform.translate(
            offset: Offset(_shakeAnim.value, 0),
            child: child,
          ),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: colors.textInputBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: authState.isCaptchaLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.gold,
                          ),
                        )
                      : authState.captcha?.captchaImageUrl != null
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.network(
                                authState.captcha!.captchaImageUrl!,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                    "Captcha Error",
                                    style: TextStyle(color: colors.textGray),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                "Loading captcha...",
                                style: TextStyle(
                                  color: colors.textGray,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: AppColors.gold),
                  onPressed: _handleRefreshCaptcha,
                  tooltip: "Refresh Captcha",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Captcha input
        _buildField(
          colors: colors,
          ctrl: _captchaCtrl,
          hint: "Enter captcha",
          icon: Icons.security_outlined,
        ),
      ],
    );
  }

  // ── Forgot Password ───────────────────────────────────────
  Widget _buildForgotPassword(VBHCColors colors) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // TODO: Navigate to ForgotPasswordScreen
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.key_outlined, size: 14, color: AppColors.gold),
              SizedBox(width: 4),
              Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── LOGIN BUTTON ──────────────────────────────────────────
  Widget _buildLoginButton(VBHCColors colors, AuthState authState) {
    final isLoading = authState.isLoading || authState.isModulesLoading;

    return ScaleTransition(
      scale: _buttonScale,
      child: GestureDetector(
        onTap: isLoading ? null : _handleLogin,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : const Text(
                    "Login Securely",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      fontFamily: 'OpenSans',
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
