import 'package:flutter/material.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: context.t('support'), body: const SupportBody());
  }
}

class SupportBody extends StatefulWidget {
  const SupportBody({super.key});

  @override
  State<SupportBody> createState() => _SupportBodyState();
}

class _SupportBodyState extends State<SupportBody> {
  final _form = GlobalKey<FormState>();
  final _msg = TextEditingController();
  String _subject = 'subj_payment';

  @override
  void dispose() {
    _msg.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    _msg.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.t('ticket_ok'))));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Help center
        AppCard(
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(color: Brand.lightBlue, shape: BoxShape.circle),
                child: const Icon(Icons.support_agent_rounded, color: Brand.navy, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.t('help_center'),
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Brand.navy)),
                    const SizedBox(height: 2),
                    Text(context.t('help_sub'), style: const TextStyle(color: Brand.muted, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
        // FAQ
        SectionTitle(context.t('faq')),
        for (final i in [1, 2, 3, 4])
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Brand.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Brand.border),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                shape: const Border(),
                collapsedShape: const Border(),
                tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                leading: const Icon(Icons.help_outline_rounded, color: Brand.green),
                title: Text(context.t('q$i'), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                children: [Text(context.t('a$i'), style: const TextStyle(color: Brand.ink, height: 1.4))],
              ),
            ),
          ),
        // Contact
        SectionTitle(context.t('contact_support')),
        AppCard(
          child: Column(
            children: [
              _ContactRow(Icons.call_rounded, context.t('c_call'), context.n('+880 1XXX-XXXXXX')),
              const Divider(height: 22),
              _ContactRow(Icons.mail_outline_rounded, context.t('c_email'), 'support@middlebank.example'),
              const Divider(height: 22),
              _ContactRow(Icons.schedule_rounded, '', context.t('c_hours')),
            ],
          ),
        ),
        // Complaint
        SectionTitle(context.t('submit_complaint')),
        AppCard(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: DropdownButtonFormField<String>(
                    // ignore: deprecated_member_use
                    value: _subject,
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: context.t('complaint_subject'),
                      prefixIcon: const Icon(Icons.flag_outlined, color: Brand.navy),
                    ),
                    items: [
                      for (final k in ['subj_payment', 'subj_delivery', 'subj_other'])
                        DropdownMenuItem(value: k, child: Text(context.t(k))),
                    ],
                    onChanged: (v) => setState(() => _subject = v ?? _subject),
                  ),
                ),
                AppField(
                  label: context.t('complaint_msg'),
                  controller: _msg,
                  maxLines: 4,
                  validator: (v) => (v ?? '').trim().isEmpty ? context.t('v_required') : null,
                ),
                AppButton(
                  label: context.t('submit'),
                  icon: Icons.send_rounded,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Brand.navy),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label.isNotEmpty) Text(label, style: const TextStyle(fontSize: 12, color: Brand.muted)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}
