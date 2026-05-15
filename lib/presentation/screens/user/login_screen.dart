import 'package:flutter/material.dart';

// ============================================================
// VBHC Login Screen - Flutter
// React Native LoginScreen.jsx → Flutter Exact Match
// ============================================================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // ── Form State ──────────────────────────────────────────
  String _username = '';
  String _password = '';
  String _entityName = '';
  bool _showPassword = false;
  bool _isLoading = false;
  bool _entityOpen = false;

  // Dummy entities list (API-ல இருந்து வரும்)
  final List<String> _entities = ['VBHC Entity 1', 'VBHC Entity 2'];

  // ── Controllers ─────────────────────────────────────────
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  // ── Animation Controllers ────────────────────────────────
  late AnimationController _logoAnimCtrl;
  late AnimationController _cardAnimCtrl;
  late AnimationController _buttonAnimCtrl;

  late Animation<double> _logoOpacity;
  late Animation<double> _cardSlide;
  late Animation<double> _buttonScale;

  // ── VBHC Brand Colors ────────────────────────────────────
  static const Color _gold = Color(0xFFC9A155);
  static const Color _bgWhite = Color(0xFFFFFFFF);
  static const Color _textBlack = Color.fromARGB(255, 233, 227, 227);
  static const Color _iconGray = Color(0xFF626567);
  static const Color _inputBorder = Color(0xFFbbbbbb);
  static const Color _trustText = Color(0xFF555555);
  static const Color _bgScreen = Color(0xFFecf0f1);

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Logo fade in (logoAnim)
    _logoAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoAnimCtrl, curve: Curves.easeOut),
    );

    // Card slide up (cardAnim: 40 → 0)
    _cardAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _cardSlide = Tween<double>(begin: 40, end: 0).animate(
      CurvedAnimation(parent: _cardAnimCtrl, curve: Curves.easeOutCubic),
    );

    // Button scale (buttonAnim: 0.9 → 1)
    _buttonAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _buttonScale = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _buttonAnimCtrl, curve: Curves.easeOut),
    );
  }

  void _startAnimations() {
    // Parallel animations - exact like RN Animated.parallel
    _logoAnimCtrl.forward();
    _cardAnimCtrl.forward();
    _buttonAnimCtrl.forward();
  }

  @override
  void dispose() {
    _logoAnimCtrl.dispose();
    _cardAnimCtrl.dispose();
    _buttonAnimCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  // ── Handle Login ─────────────────────────────────────────
  void _handleLogin() {
    if (_entityName.isEmpty) {
      _showToast("Please select entity");
      return;
    }
    if (_username.isEmpty || _password.isEmpty) {
      _showToast("Enter username & password");
      return;
    }

    setState(() => _isLoading = true);

    // API call இங்க வரும் - இப்போ simulate பண்றோம்
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      _showToast("Login Successful ✅");
      // Navigator.pushReplacementNamed(context, '/main');
    });
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontFamily: 'OpenSans')),
        backgroundColor: _gold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ── Entity Dropdown ──────────────────────────────────────
  void _showEntitySheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Select Entity",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'OpenSans',
              ),
            ),
            const SizedBox(height: 8),
            ..._entities.map((e) => ListTile(
                  title:
                      Text(e, style: const TextStyle(fontFamily: 'OpenSans')),
                  leading: const Icon(Icons.business_outlined, color: _gold),
                  onTap: () {
                    setState(() => _entityName = e);
                    Navigator.pop(ctx);
                  },
                )),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgWhite,
      body: SafeArea(
        child: Column(
          children: [
            // ── HEADER (vbhc_portrait image) ──────────────
            _buildHeader(),

            // ── SCROLLABLE BODY ───────────────────────────
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      // ── LOGIN CARD ─────────────────────
                      _buildLoginCard(),
                      const SizedBox(height: 12),

                      // ── Version Text ───────────────────
                      Text(
                        "V 1.0 | 13-Nov-2024",
                        style: TextStyle(
                          color: _iconGray,
                          fontSize: 12,
                          fontFamily: 'OpenSans',
                        ),
                        textAlign: TextAlign.center,
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
  }

  // ── HEADER WIDGET ────────────────────────────────────────
  Widget _buildHeader() {
    return FadeTransition(
      opacity: _logoOpacity,
      child: Container(
        height: 160,
        width: double.infinity,
        color: _bgWhite,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Image.asset(
          '../../assets/images/vbhc_portrait.png',
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Center(
            child: Text(
              "VBHC",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: _gold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── LOGIN CARD ───────────────────────────────────────────
  Widget _buildLoginCard() {
    return AnimatedBuilder(
      animation: Listenable.merge([_cardAnimCtrl, _logoAnimCtrl]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _cardSlide.value),
          child: Opacity(
            opacity: _logoOpacity.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: _bgWhite,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, 8),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Welcome Header ───────────────────────────
            _buildWelcomeHeader(),
            const SizedBox(height: 18),

            // ── Trust Row ────────────────────────────────
            _buildTrustRow(),
            const SizedBox(height: 18),

            // ── Entity Dropdown ──────────────────────────
            _buildEntityField(),
            const SizedBox(height: 14),

            // ── Username ─────────────────────────────────
            _buildTextField(
              hint: "Username",
              icon: Icons.person_outline,
              onChanged: (v) => _username = v,
              controller: _usernameCtrl,
            ),
            const SizedBox(height: 14),

            // ── Password ─────────────────────────────────
            _buildPasswordField(),
            const SizedBox(height: 8),

            // ── Forgot Password ──────────────────────────
            _buildForgotPassword(),
            const SizedBox(height: 10),

            // ── Login Button ─────────────────────────────
            _buildLoginButton(),
            const SizedBox(height: 16),

            // ── Quote ────────────────────────────────────
            Center(
              child: Text(
                '"Security is not a product, but a process."',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: _trustText,
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

  // ── Welcome Header ───────────────────────────────────────
  Widget _buildWelcomeHeader() {
    return Column(
      children: [
        Center(
          child: Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _textBlack,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            "Sign in to access your secure VBHC workspace",
            style: TextStyle(
              fontSize: 13,
              color: _trustText,
              fontFamily: 'OpenSans',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // ── Trust Row (Secure | Encrypted | Enterprise) ──────────
  Widget _buildTrustRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _trustItem(Icons.shield_outlined, "Secure Login"),
        _trustItem(Icons.lock_outline, "Encrypted Data"),
        _trustItem(Icons.business_outlined, "Enterprise Ready"),
      ],
    );
  }

  Widget _trustItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _gold),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _trustText,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }

  // ── Entity Field ─────────────────────────────────────────
  Widget _buildEntityField() {
    return GestureDetector(
      onTap: _showEntitySheet,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: _bgWhite,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _inputBorder),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _entityName.isEmpty ? "Select Entity" : _entityName,
              style: TextStyle(
                color: _entityName.isEmpty ? _iconGray : _textBlack,
                fontFamily: 'OpenSans',
                fontSize: 15,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: _iconGray),
          ],
        ),
      ),
    );
  }

  // ── Text Field ───────────────────────────────────────────
  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
    required TextEditingController controller,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: _bgWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _inputBorder),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          color: _textBlack,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: _iconGray,
            fontFamily: 'OpenSans',
          ),
          prefixIcon: Icon(icon, color: _iconGray, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // ── Password Field ───────────────────────────────────────
  Widget _buildPasswordField() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: _bgWhite,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _inputBorder),
      ),
      child: TextField(
        controller: _passwordCtrl,
        obscureText: !_showPassword,
        onChanged: (v) => _password = v,
        style: const TextStyle(color: _textBlack, fontFamily: 'OpenSans'),
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: const TextStyle(color: _iconGray, fontFamily: 'OpenSans'),
          prefixIcon:
              const Icon(Icons.lock_outline, color: _iconGray, size: 20),
          suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: _iconGray,
              size: 22,
            ),
            onPressed: () => setState(() => _showPassword = !_showPassword),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
        ),
      ),
    );
  }

  // ── Forgot Password ──────────────────────────────────────
  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, '/forgot-password');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _gold.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.key_outlined, size: 14, color: _gold),
              const SizedBox(width: 4),
              const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _gold,
                  fontFamily: 'OpenSans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Login Button ─────────────────────────────────────────
  Widget _buildLoginButton() {
    return ScaleTransition(
      scale: _buttonScale,
      child: GestureDetector(
        onTap: _isLoading ? null : _handleLogin,
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: _gold, // appThemeColor = gold
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: _isLoading
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
