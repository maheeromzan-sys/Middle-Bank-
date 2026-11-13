import 'package:flutter/material.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Brand.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, box) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: box.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // ── Hero ──
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFCFE4FF), Brand.lightBlue, Brand.white],
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                      child: Column(
                        children: [
                          const Align(alignment: Alignment.centerRight, child: LangSwitch(onDark: false)),
                          const SizedBox(height: 4),
                          const ShieldLogo(size: 72),
                          const SizedBox(height: 10),
                          const BrandTitle(fontSize: 32),
                          const SizedBox(height: 4),
                          Text(
                            context.t('slogan'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Brand.navy,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const _EscrowIllustration(),
                          const SizedBox(height: 14),
                          Text(
                            context.t('safe_secure'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Brand.navy),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context.t('buy_sell'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 14, color: Brand.ink),
                          ),
                        ],
                      ),
                    ),
                    // ── Actions ──
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 6, 20, 0),
                      child: Column(
                        children: [
                          AppButton(
                            label: context.t('login'),
                            icon: Icons.login_rounded,
                            onPressed: () => Navigator.pushNamed(context, '/login'),
                          ),
                          const SizedBox(height: 12),
                          AppButton(
                            label: context.t('create_account'),
                            icon: Icons.person_add_alt_1_rounded,
                            outlined: true,
                            onPressed: () => Navigator.pushNamed(context, '/register'),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              const Expanded(child: Divider(color: Brand.border)),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(context.t('continue_as'),
                                    style: const TextStyle(color: Brand.navy, fontSize: 13)),
                              ),
                              const Expanded(child: Divider(color: Brand.border)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          AppButton(
                            label: context.t('continue_buyer'),
                            icon: Icons.shopping_cart_outlined,
                            color: const Color(0xFF0A55C8),
                            onPressed: () {
                              context.appRead.setSeller(false);
                              Navigator.pushNamed(context, '/buyer');
                            },
                          ),
                          const SizedBox(height: 12),
                          AppButton(
                            label: context.t('continue_seller'),
                            icon: Icons.storefront_outlined,
                            color: Brand.green,
                            onPressed: () {
                              context.appRead.setSeller(true);
                              Navigator.pushNamed(context, '/seller');
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                    // ── Feature strip ──
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      decoration: const BoxDecoration(
                        color: Brand.white,
                        border: Border(top: BorderSide(color: Brand.border)),
                      ),
                      child: Row(
                        children: [
                          _Feature(Icons.verified_user_outlined, context.t('secure_payment')),
                          _Feature(Icons.receipt_long_outlined, context.t('txn_receipt')),
                          _Feature(Icons.search_rounded, context.t('track_txn')),
                          _Feature(Icons.headset_mic_outlined, context.t('support')),
                        ],
                      ),
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
}

class _Feature extends StatelessWidget {
  const _Feature(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Brand.navy, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Brand.navy, height: 1.2),
          ),
        ],
      ),
    );
  }
}

/// Buyer  ⇄  shield with lock  ⇄  Seller
class _EscrowIllustration extends StatelessWidget {
  const _EscrowIllustration();

  @override
  Widget build(BuildContext context) {
    Widget role(IconData icon, String label, Color color) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
              child: Text(label,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ],
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        role(Icons.person_rounded, context.t('buyer'), const Color(0xFF0A3FA8)),
        const Expanded(child: Icon(Icons.sync_alt_rounded, color: Color(0xFF3FB6E8), size: 28)),
        Container(
          width: 84,
          height: 94,
          decoration: BoxDecoration(
            color: Brand.green,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(44),
              bottomRight: Radius.circular(44),
            ),
            boxShadow: [BoxShadow(color: Brand.green.withAlpha(90), blurRadius: 16, offset: const Offset(0, 6))],
          ),
          child: const Icon(Icons.lock_rounded, color: Colors.white, size: 44),
        ),
        const Expanded(child: Icon(Icons.sync_alt_rounded, color: Color(0xFF3FB6E8), size: 28)),
        role(Icons.storefront_rounded, context.t('seller'), Brand.green),
      ],
    );
  }
}
