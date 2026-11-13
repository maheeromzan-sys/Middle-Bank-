import 'package:flutter/material.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

String? _mobileValidator(BuildContext c, String? v) {
  final s = (v ?? '').trim();
  return RegExp(r'^01\d{9}$').hasMatch(s) ? null : c.t('v_mobile');
}

String? _passValidator(BuildContext c, String? v) =>
    (v ?? '').length >= 6 ? null : c.t('v_pass');

/// Navy header shared by Login / Register.
class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 30),
      decoration: const BoxDecoration(
        gradient: Brand.navyGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                if (Navigator.of(context).canPop())
                  IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                const Spacer(),
                const LangSwitch(),
              ],
            ),
            const ShieldLogo(size: 54, onDark: true),
            const SizedBox(height: 8),
            const BrandTitle(fontSize: 24, onDark: true),
            const SizedBox(height: 14),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withAlpha(210), fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Login ─────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _mobile = TextEditingController();
  final _pass = TextEditingController();
  bool _hide = true;
  bool _asSeller = false;

  @override
  void dispose() {
    _mobile.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final app = context.appRead;
    app.setSeller(_asSeller);
    Navigator.of(context).pushNamedAndRemoveUntil(
      _asSeller ? '/seller' : '/buyer',
      (r) => r.settings.name == '/welcome',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _AuthHeader(title: context.t('welcome_back'), subtitle: context.t('login_sub')),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppField(
                      label: context.t('mobile'),
                      controller: _mobile,
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      hint: '01XXXXXXXXX',
                      validator: (v) => _mobileValidator(context, v),
                    ),
                    AppField(
                      label: context.t('password'),
                      controller: _pass,
                      icon: Icons.lock_outline_rounded,
                      obscure: _hide,
                      validator: (v) => _passValidator(context, v),
                      suffix: IconButton(
                        icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () => setState(() => _hide = !_hide),
                      ),
                    ),
                    Text(context.t('login_as'),
                        style: const TextStyle(fontWeight: FontWeight.w700, color: Brand.navy)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _RoleChip(
                            icon: Icons.person_rounded,
                            label: context.t('buyer'),
                            selected: !_asSeller,
                            color: const Color(0xFF0A55C8),
                            onTap: () => setState(() => _asSeller = false),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _RoleChip(
                            icon: Icons.storefront_rounded,
                            label: context.t('seller'),
                            selected: _asSeller,
                            color: Brand.green,
                            onTap: () => setState(() => _asSeller = true),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(context.t('forgot_demo')))),
                        child: Text(context.t('forgot'),
                            style: const TextStyle(color: Brand.navy, fontWeight: FontWeight.w700)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    AppButton(label: context.t('login'), icon: Icons.login_rounded, onPressed: _submit),
                    const SizedBox(height: 12),
                    AppButton(
                      label: context.t('new_account'),
                      icon: Icons.person_add_alt_1_rounded,
                      outlined: true,
                      onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(context.t('demo_banner'),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 11, color: Brand.muted)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? color : Brand.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? color : Brand.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: selected ? Colors.white : color),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(fontWeight: FontWeight.w700, color: selected ? Colors.white : color)),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────── Register ─────────────────────────

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _mobile = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    for (final c in [_name, _mobile, _email, _pass, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final app = context.appRead;
    app.setProfile(_name.text.trim(), _mobile.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t('account_created'))));
    Navigator.of(context).pushNamedAndRemoveUntil('/buyer', (r) => r.settings.name == '/welcome');
  }

  @override
  Widget build(BuildContext context) {
    String? req(String? v) => (v ?? '').trim().isEmpty ? context.t('v_required') : null;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _AuthHeader(title: context.t('create_account'), subtitle: context.t('create_account_sub')),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    AppField(
                      label: context.t('full_name'),
                      controller: _name,
                      icon: Icons.person_outline_rounded,
                      validator: req,
                    ),
                    AppField(
                      label: context.t('mobile'),
                      controller: _mobile,
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                      maxLength: 11,
                      hint: '01XXXXXXXXX',
                      validator: (v) => _mobileValidator(context, v),
                    ),
                    AppField(
                      label: context.t('email'),
                      controller: _email,
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch((v ?? '').trim())
                              ? null
                              : context.t('v_email'),
                    ),
                    AppField(
                      label: context.t('password'),
                      controller: _pass,
                      icon: Icons.lock_outline_rounded,
                      obscure: _hide,
                      validator: (v) => _passValidator(context, v),
                      suffix: IconButton(
                        icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                        onPressed: () => setState(() => _hide = !_hide),
                      ),
                    ),
                    AppField(
                      label: context.t('confirm_password'),
                      controller: _confirm,
                      icon: Icons.lock_reset_rounded,
                      obscure: _hide,
                      validator: (v) => v == _pass.text ? null : context.t('v_match'),
                    ),
                    const SizedBox(height: 4),
                    AppButton(
                      label: context.t('register_btn'),
                      icon: Icons.how_to_reg_rounded,
                      color: Brand.green,
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(context.t('have_account'),
                          style: const TextStyle(color: Brand.navy, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
