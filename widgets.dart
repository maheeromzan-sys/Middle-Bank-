import 'package:flutter/material.dart';

import 'state.dart';
import 'theme.dart';

// ───────────────────────── Logo ─────────────────────────

class ShieldLogo extends StatelessWidget {
  const ShieldLogo({super.key, this.size = 80, this.onDark = false});
  final double size;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 1.12,
      child: CustomPaint(
        painter: _ShieldPainter(onDark),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: size * 0.1),
            child: Text(
              'M',
              style: TextStyle(
                fontSize: size * 0.52,
                fontWeight: FontWeight.w900,
                color: onDark ? Brand.navy : Brand.white,
                height: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShieldPainter extends CustomPainter {
  _ShieldPainter(this.onDark);
  final bool onDark;

  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final shield = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, h * 0.14)
      ..lineTo(w, h * 0.55)
      ..quadraticBezierTo(w, h * 0.86, w * 0.5, h)
      ..quadraticBezierTo(0, h * 0.86, 0, h * 0.55)
      ..lineTo(0, h * 0.14)
      ..close();
    canvas.drawPath(
      shield,
      Paint()
        ..color = onDark ? Brand.white : Brand.navy,
    );
    // green swoosh
    final swoosh = Path()
      ..moveTo(-w * 0.05, h * 0.74)
      ..quadraticBezierTo(w * 0.45, h * 0.62, w * 1.08, h * 0.26);
    canvas.drawPath(
      swoosh,
      Paint()
        ..color = Brand.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = w * 0.075
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _ShieldPainter old) => old.onDark != onDark;
}

class BrandTitle extends StatelessWidget {
  const BrandTitle({super.key, this.fontSize = 28, this.onDark = false});
  final double fontSize;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: 'MIDDLE ',
            style: TextStyle(color: onDark ? Brand.white : Brand.navy),
          ),
          TextSpan(
            text: 'BANK',
            style: TextStyle(color: onDark ? const Color(0xFF4FE3A8) : Brand.green),
          ),
        ]),
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ───────────────────────── Buttons / fields ─────────────────────────

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color = Brand.navy,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color color;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final fg = outlined ? color : Brand.white;
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 22, color: fg), const SizedBox(width: 10)],
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: fg),
          ),
        ),
      ],
    );
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(30));
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Brand.white,
                side: BorderSide(color: color.withAlpha(90)),
                shape: shape,
                elevation: 0,
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                disabledBackgroundColor: Brand.border,
                shape: shape,
                elevation: 3,
                shadowColor: color.withAlpha(110),
              ),
              child: child,
            ),
    );
  }
}

class AppField extends StatelessWidget {
  const AppField({
    super.key,
    required this.label,
    this.controller,
    this.icon,
    this.validator,
    this.keyboardType,
    this.obscure = false,
    this.suffix,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefixText,
    this.hint,
    this.maxLength,
  });

  final String label;
  final TextEditingController? controller;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffix;
  final bool readOnly;
  final int maxLines;
  final String? prefixText;
  final String? hint;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscure,
        readOnly: readOnly,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          counterText: '',
          prefixText: prefixText,
          prefixIcon: icon == null ? null : Icon(icon, color: Brand.navy),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}

// ───────────────────────── Language switch ─────────────────────────

class LangSwitch extends StatelessWidget {
  const LangSwitch({super.key, this.onDark = true});
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final bn = context.app.bangla;
    Widget seg(String text, bool selected, bool toBangla) {
      return GestureDetector(
        onTap: () => context.appRead.setBangla(toBangla),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? Brand.green : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected
                  ? Brand.white
                  : (onDark ? Brand.white : Brand.navy),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: onDark ? Colors.white.withAlpha(36) : Brand.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: onDark ? Colors.white.withAlpha(70) : Brand.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [seg('বাংলা', bn, true), seg('English', !bn, false)],
      ),
    );
  }
}

// ───────────────────────── Layout helpers ─────────────────────────

/// Standard inner screen: navy app bar + light-blue body + demo banner.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBanner = true,
  });

  final String title;
  final Widget body;
  final bool showBanner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 12), child: Center(child: LangSwitch())),
        ],
      ),
      body: Column(
        children: [
          if (showBanner) const DemoBanner(),
          Expanded(child: SafeArea(top: false, child: body)),
        ],
      ),
    );
  }
}

class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFFF4D6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, size: 16, color: Brand.amber),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              context.t('demo_banner'),
              style: const TextStyle(fontSize: 12, color: Color(0xFF7A5600), fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap});
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Brand.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Brand.navy.withAlpha(18), blurRadius: 14, offset: const Offset(0, 5)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 4, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Brand.navy)),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow(this.label, this.value, {super.key, this.bold = false, this.valueColor});
  final String label;
  final String value;
  final bool bold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: const TextStyle(color: Brand.muted, fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
                color: valueColor ?? Brand.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip(this.text, {super.key, this.color = Brand.green});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(28),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

class ActionTile extends StatelessWidget {
  const ActionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color = Brand.navy,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Brand.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Brand.border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 26),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Brand.navy, height: 1.25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 3-column grid of [ActionTile]s with a fixed tile height (safe on small phones).
class ActionGrid extends StatelessWidget {
  const ActionGrid({super.key, required this.tiles, this.columns = 3});
  final List<Widget> tiles;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: columns,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: columns == 3 ? 0.86 : 1.45,
      children: tiles,
    );
  }
}
