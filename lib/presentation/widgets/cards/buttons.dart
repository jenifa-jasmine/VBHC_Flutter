import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  CUSTOM BUTTON COLLECTION — All-Screen Usage
// ─────────────────────────────────────────────

// ══════════════════════════════════════════════
// 1. PRIMARY BUTTON  (Filled, rounded corners)
// ══════════════════════════════════════════════
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF4F46E5).withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 2. SECONDARY BUTTON  (Outlined)
// ══════════════════════════════════════════════
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? width;
  final Color? borderColor;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.width,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = borderColor ?? const Color(0xFF4F46E5);
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: color, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 3. TEXT BUTTON  (Ghost / inline action)
// ══════════════════════════════════════════════
class GhostButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;

  const GhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? const Color(0xFF4F46E5);
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: c,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: c,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 4. ICON BUTTON  (Circular / square)
// ══════════════════════════════════════════════
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final bool rounded;
  final String? tooltip;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 48,
    this.rounded = true,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFFF3F4F6);
    final ic = iconColor ?? const Color(0xFF1F2937);
    final widget = Material(
      color: bg,
      borderRadius: BorderRadius.circular(rounded ? size / 2 : 12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(rounded ? size / 2 : 12),
        child: SizedBox(
          width: size,
          height: size,
          child: Icon(icon, color: ic, size: size * 0.42),
        ),
      ),
    );
    if (tooltip != null) return Tooltip(message: tooltip!, child: widget);
    return widget;
  }
}

// ══════════════════════════════════════════════
// 5. GRADIENT BUTTON
// ══════════════════════════════════════════════
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final List<Color> colors;
  final IconData? icon;
  final double? width;

  const GradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.colors = const [Color(0xFF6366F1), Color(0xFF8B5CF6)],
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: onPressed == null
                ? colors.map((c) => c.withOpacity(0.5)).toList()
                : colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: onPressed == null
              ? []
              : [
                  BoxShadow(
                    color: colors.last.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 6. DANGER / DESTRUCTIVE BUTTON
// ══════════════════════════════════════════════
class DangerButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool outlined;

  const DangerButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    const red = Color(0xFFEF4444);
    if (outlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: red,
            side: const BorderSide(color: red, width: 1.5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          icon: const Icon(Icons.delete_outline, size: 18),
          label: Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
        ),
        icon: const Icon(Icons.delete_outline, size: 18),
        label: Text(label,
            style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 7. TOGGLE BUTTON (Active / Inactive state)
// ══════════════════════════════════════════════
class CustomToggleButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final ValueChanged<bool> onChanged;
  final IconData? activeIcon;
  final IconData? inactiveIcon;

  const CustomToggleButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onChanged,
    this.activeIcon,
    this.inactiveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 48,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4F46E5) : const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive ? const Color(0xFF4F46E5) : const Color(0xFFE5E7EB),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged(!isActive),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isActive && activeIcon != null) ...[
                  Icon(activeIcon, size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                ] else if (!isActive && inactiveIcon != null) ...[
                  Icon(inactiveIcon,
                      size: 16, color: const Color(0xFF6B7280)),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? Colors.white
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 8. FAB — Extended Floating Action Button
// ══════════════════════════════════════════════
class CustomFAB extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomFAB({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? const Color(0xFF4F46E5),
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: Icon(icon),
      label: Text(
        label,
        style:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 9. SOCIAL / OAUTH BUTTON
// ══════════════════════════════════════════════
class SocialButton extends StatelessWidget {
  final String label;
  final Widget logo; // e.g. Image.asset or SvgPicture
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const SocialButton({
    super.key,
    required this.label,
    required this.logo,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: textColor ?? const Color(0xFF1F2937),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 22, height: 22, child: logo),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor ?? const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════
// 10. CHIP / TAG BUTTON
// ══════════════════════════════════════════════
class ChipButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final IconData? icon;
  final Color? selectedColor;

  const ChipButton({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.icon,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = selectedColor ?? const Color(0xFF4F46E5);
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon,
                size: 14,
                color: isSelected ? Colors.white : const Color(0xFF6B7280)),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: const Color(0xFFF3F4F6),
      selectedColor: color,
      checkmarkColor: Colors.white,
      showCheckmark: false,
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: isSelected ? Colors.white : const Color(0xFF374151),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? color : const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }
}

// ══════════════════════════════════════════════
// USAGE EXAMPLE  —  Demo Screen
// ══════════════════════════════════════════════
class ButtonDemoScreen extends StatefulWidget {
  const ButtonDemoScreen({super.key});
  @override
  State<ButtonDemoScreen> createState() => _ButtonDemoScreenState();
}

class _ButtonDemoScreenState extends State<ButtonDemoScreen> {
  bool _loading = false;
  bool _toggle = false;
  bool _chipA = true;
  bool _chipB = false;

  void _simulateLoad() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Custom Buttons'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1F2937),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFE5E7EB), height: 1),
        ),
      ),
      floatingActionButton: CustomFAB(
        label: 'New Item',
        icon: Icons.add_rounded,
        onPressed: () {},
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _section('Primary Button'),
          PrimaryButton(
              label: 'Continue',
              onPressed: _simulateLoad,
              isLoading: _loading,
              icon: Icons.arrow_forward_rounded),
          const SizedBox(height: 24),

          _section('Secondary Button'),
          SecondaryButton(
              label: 'Learn More',
              onPressed: () {},
              icon: Icons.info_outline_rounded),
          const SizedBox(height: 24),

          _section('Ghost Button'),
          GhostButton(
              label: 'Skip for now',
              onPressed: () {},
              icon: Icons.skip_next_rounded),
          const SizedBox(height: 24),

          _section('Icon Buttons'),
          Row(
            children: [
              CustomIconButton(
                  icon: Icons.favorite_border_rounded,
                  onPressed: () {},
                  tooltip: 'Like'),
              const SizedBox(width: 12),
              CustomIconButton(
                  icon: Icons.share_rounded,
                  onPressed: () {},
                  rounded: false,
                  tooltip: 'Share'),
              const SizedBox(width: 12),
              CustomIconButton(
                  icon: Icons.bookmark_border_rounded,
                  onPressed: () {},
                  backgroundColor: const Color(0xFFFEF3C7),
                  iconColor: const Color(0xFFD97706),
                  tooltip: 'Save'),
            ],
          ),
          const SizedBox(height: 24),

          _section('Gradient Button'),
          GradientButton(
              label: 'Get Started',
              onPressed: () {},
              icon: Icons.rocket_launch_rounded),
          const SizedBox(height: 24),

          _section('Danger Buttons'),
          DangerButton(label: 'Delete Account', onPressed: () {}),
          const SizedBox(height: 10),
          DangerButton(
              label: 'Remove', onPressed: () {}, outlined: true),
          const SizedBox(height: 24),

          _section('Toggle Button'),
          CustomToggleButton(
            label: _toggle ? 'Notifications On' : 'Notifications Off',
            isActive: _toggle,
            onChanged: (v) => setState(() => _toggle = v),
            activeIcon: Icons.notifications_active_rounded,
            inactiveIcon: Icons.notifications_off_outlined,
          ),
          const SizedBox(height: 24),

          _section('Social Button'),
          SocialButton(
            label: 'Continue with Google',
            logo: const Icon(Icons.g_mobiledata,
                color: Color(0xFF4285F4), size: 22),
            onPressed: () {},
          ),
          const SizedBox(height: 24),

          _section('Chip / Tag Buttons'),
          Wrap(
            spacing: 8,
            children: [
              ChipButton(
                  label: 'Design',
                  isSelected: _chipA,
                  icon: Icons.brush_rounded,
                  onSelected: (v) => setState(() => _chipA = v)),
              ChipButton(
                  label: 'Flutter',
                  isSelected: _chipB,
                  icon: Icons.flutter_dash,
                  selectedColor: const Color(0xFF0EA5E9),
                  onSelected: (v) => setState(() => _chipB = v)),
              ChipButton(
                  label: 'Mobile',
                  isSelected: false,
                  icon: Icons.phone_android_rounded,
                  onSelected: (_) {}),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
            letterSpacing: 0.5,
          ),
        ),
      );
}

// ══════════════════════════════════════════════
// MAIN  (run standalone)
// ══════════════════════════════════════════════
void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ButtonDemoScreen(),
      ),
    );