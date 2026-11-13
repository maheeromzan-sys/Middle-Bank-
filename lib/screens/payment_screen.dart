import 'package:flutter/material.dart';

import '../demo_data.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets.dart';
import 'shell.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _method = 'method_partner';

  static const _methods = [
    ('method_partner', Icons.account_balance_rounded),
    ('method_wallet', Icons.account_balance_wallet_rounded),
    ('method_card', Icons.credit_card_rounded),
  ];

  Future<void> _confirm(Txn txn) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        icon: const Icon(Icons.shield_rounded, color: Brand.green, size: 36),
        title: Text(ctx.t('confirm_title'), textAlign: TextAlign.center),
        content: Text(ctx.t('confirm_body'), textAlign: TextAlign.center),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(ctx.t('cancel'))),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Brand.green),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(ctx.t('confirm')),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final app = context.appRead;
    txn.method = _method;
    if (txn.done < 2) txn.done = 2;
    app.touch();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t('status_confirmed'))));
    Navigator.pushReplacementNamed(context, '/receipt');
  }

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final txn = pickCurrent(app);

    if (txn == null) {
      return AppScaffold(
        title: context.t('secure_payment'),
        body: Center(child: Text(context.t('pick_txn'))),
      );
    }

    return AppScaffold(
      title: context.t('secure_payment'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Transaction details
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.t('txn_details'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Brand.navy)),
                const Divider(height: 20),
                InfoRow(context.t('txn_id'), context.n(txn.id)),
                InfoRow(context.t('product'), txn.product),
                InfoRow(context.t('seller'), txn.seller),
                InfoRow(context.t('delivery'), txn.delivery),
                const Divider(height: 20),
                InfoRow(context.t('amount'), context.money(txn.amount), bold: true, valueColor: Brand.navy),
              ],
            ),
          ),
          // Payment status
          AppCard(
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Brand.navy),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(context.t('payment_status'),
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
                StatusChip(
                  txn.paid ? context.t('status_confirmed') : context.t('status_pending'),
                  color: txn.paid ? Brand.green : Brand.amber,
                ),
              ],
            ),
          ),
          // Payment method
          SectionTitle(context.t('payment_method')),
          for (final m in _methods)
            _MethodTile(
              icon: m.$2,
              label: context.t(m.$1),
              selected: (txn.paid ? txn.method : _method) == m.$1,
              onTap: txn.paid ? null : () => setState(() => _method = m.$1),
            ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4D6),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.science_outlined, color: Brand.amber),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(context.t('no_real_money'),
                      style: const TextStyle(color: Color(0xFF7A5600), fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (txn.paid)
            AppButton(
              label: context.t('txn_receipt'),
              icon: Icons.receipt_long_rounded,
              onPressed: () => Navigator.pushReplacementNamed(context, '/receipt'),
            )
          else
            AppButton(
              label: context.t('demo_pay_confirm'),
              icon: Icons.lock_rounded,
              color: Brand.green,
              onPressed: () => _confirm(txn),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile({required this.icon, required this.label, required this.selected, required this.onTap});
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? Brand.white : Brand.white.withAlpha(200),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? Brand.green : Brand.border, width: selected ? 2 : 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: Brand.navy),
              const SizedBox(width: 12),
              Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700))),
              Icon(
                selected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: selected ? Brand.green : Brand.border,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
