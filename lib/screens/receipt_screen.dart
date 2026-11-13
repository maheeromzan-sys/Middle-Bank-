import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';
import 'shell.dart';

class ReceiptScreen extends StatelessWidget {
  const ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final txn = pickCurrent(app);

    if (txn == null) {
      return AppScaffold(
        title: context.t('txn_receipt'),
        body: Center(child: Text(context.t('pick_txn'))),
      );
    }

    final statusText = txn.paid ? context.t('status_confirmed') : context.t('status_pending');

    return AppScaffold(
      title: context.t('txn_receipt'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                // Receipt header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: const BoxDecoration(
                    gradient: Brand.navyGradient,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const ShieldLogo(size: 40, onDark: true),
                      const SizedBox(height: 6),
                      const BrandTitle(fontSize: 20, onDark: true),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Brand.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(context.t('demo_receipt'),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(context.t('unique_id'), style: const TextStyle(color: Brand.muted, fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(context.n(txn.id),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Brand.navy)),
                      const Divider(height: 24),
                      Text(context.t('buyer_details'),
                          style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.green)),
                      InfoRow(context.t('name'), txn.buyer),
                      InfoRow(context.t('mobile'), context.n(txn.buyerPhone)),
                      const Divider(height: 24),
                      Text(context.t('seller_details'),
                          style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.green)),
                      InfoRow(context.t('name'), txn.seller),
                      InfoRow(context.t('mobile'), context.n(txn.sellerPhone)),
                      const Divider(height: 24),
                      InfoRow(context.t('product'), txn.product),
                      InfoRow(context.t('date_time'), context.date(txn.createdAt)),
                      InfoRow(context.t('amount'), context.money(txn.amount), bold: true, valueColor: Brand.navy),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(context.t('payment_status'),
                                style: const TextStyle(color: Brand.muted, fontSize: 13)),
                          ),
                          StatusChip(statusText, color: txn.paid ? Brand.green : Brand.amber),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AppButton(
            label: context.t('download_receipt'),
            icon: Icons.download_rounded,
            color: Brand.green,
            onPressed: () async {
              final text = StringBuffer()
                ..writeln('MIDDLE BANK - DEMO RECEIPT')
                ..writeln('ID: ${txn.id}')
                ..writeln('Buyer: ${txn.buyer} (${txn.buyerPhone})')
                ..writeln('Seller: ${txn.seller} (${txn.sellerPhone})')
                ..writeln('Product: ${txn.product}')
                ..writeln('Amount: BDT ${txn.amount.round()}')
                ..writeln('Date: ${txn.createdAt}')
                ..writeln('Status: ${txn.paid ? 'Confirmed (demo)' : 'Pending'}');
              await Clipboard.setData(ClipboardData(text: text.toString()));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(context.t('receipt_copied'))));
            },
          ),
          const SizedBox(height: 12),
          AppButton(
            label: context.t('track_txn'),
            icon: Icons.travel_explore_rounded,
            outlined: true,
            onPressed: () => Navigator.pushNamed(context, '/track'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
