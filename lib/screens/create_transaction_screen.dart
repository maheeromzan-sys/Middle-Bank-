import 'package:flutter/material.dart';

import '../demo_data.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() => _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final _form = GlobalKey<FormState>();
  final _sellerName = TextEditingController();
  final _sellerMobile = TextEditingController();
  final _product = TextEditingController();
  final _price = TextEditingController();
  final _delivery = TextEditingController();

  @override
  void dispose() {
    for (final c in [_sellerName, _sellerMobile, _product, _price, _delivery]) {
      c.dispose();
    }
    super.dispose();
  }

  void _create() {
    if (!_form.currentState!.validate()) return;
    final app = context.appRead;
    final txn = Txn(
      id: app.newTxnId(),
      product: _product.text.trim(),
      seller: _sellerName.text.trim(),
      sellerPhone: _sellerMobile.text.trim(),
      buyer: app.userName,
      buyerPhone: app.userMobile,
      amount: double.parse(_price.text.trim()),
      delivery: _delivery.text.trim(),
      createdAt: DateTime.now(),
    );
    app.add(txn);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txn.id)));
    Navigator.pushReplacementNamed(context, '/pay');
  }

  @override
  Widget build(BuildContext context) {
    String? req(String? v) => (v ?? '').trim().isEmpty ? context.t('v_required') : null;
    return AppScaffold(
      title: context.t('create_title'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(context.t('seller_info')),
              AppField(
                label: context.t('seller_name'),
                controller: _sellerName,
                icon: Icons.storefront_outlined,
                validator: req,
              ),
              AppField(
                label: context.t('seller_mobile'),
                controller: _sellerMobile,
                icon: Icons.phone_android_rounded,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                hint: '01XXXXXXXXX',
                validator: (v) =>
                    RegExp(r'^01\d{9}$').hasMatch((v ?? '').trim()) ? null : context.t('v_mobile'),
              ),
              SectionTitle(context.t('product_info')),
              AppField(
                label: context.t('product_name'),
                controller: _product,
                icon: Icons.inventory_2_outlined,
                validator: req,
              ),
              AppField(
                label: context.t('product_price'),
                controller: _price,
                icon: Icons.payments_outlined,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
                validator: (v) {
                  final d = double.tryParse((v ?? '').trim());
                  return (d == null || d <= 0) ? context.t('v_price') : null;
                },
              ),
              // Auto-generated, read-only transaction ID.
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Brand.lightBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Brand.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.tag_rounded, color: Brand.navy),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${context.t('txn_id')} (${context.t('auto_generated')})',
                              style: const TextStyle(fontSize: 12, color: Brand.muted)),
                          const SizedBox(height: 2),
                          Text(context.n(context.app.newTxnId()),
                              style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.navy)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SectionTitle(context.t('delivery_info')),
              AppField(
                label: context.t('delivery_info'),
                hint: context.t('delivery_hint'),
                controller: _delivery,
                icon: Icons.local_shipping_outlined,
                maxLines: 3,
                validator: req,
              ),
              const SizedBox(height: 4),
              AppButton(
                label: context.t('create_btn'),
                icon: Icons.check_circle_outline_rounded,
                color: Brand.green,
                onPressed: _create,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
