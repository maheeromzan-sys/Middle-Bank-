import 'package:flutter/material.dart';

import '../state.dart';
import '../theme.dart';
import '../widgets.dart';
import 'shell.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(title: context.t('track_txn'), body: const TrackBody());
  }
}

class TrackBody extends StatelessWidget {
  const TrackBody({super.key});

  static const _steps = [
    ('s_created', Icons.note_add_rounded),
    ('s_paid', Icons.verified_user_rounded),
    ('s_shipped', Icons.local_shipping_rounded),
    ('s_delivered', Icons.inventory_2_rounded),
    ('s_buyer_ok', Icons.thumb_up_alt_rounded),
    ('s_released', Icons.payments_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final txn = pickCurrent(app);
    if (txn == null) return Center(child: Text(context.t('pick_txn')));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Summary
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(txn.product,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                  ),
                  Text(context.money(txn.amount),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.navy)),
                ],
              ),
              const SizedBox(height: 2),
              Text(context.n(txn.id), style: const TextStyle(fontSize: 12, color: Brand.muted)),
              const SizedBox(height: 10),
              StatusChip(context.t(txn.statusKey), color: statusColor(txn.done)),
              if (app.txns.length > 1) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final t in app.txns)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(context.n(t.id.split('-').last)),
                            selected: identical(t, txn),
                            selectedColor: Brand.lightBlue,
                            onSelected: (_) => context.appRead.select(t),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        // Timeline
        AppCard(
          child: Column(
            children: [
              for (int i = 0; i < _steps.length; i++)
                _TimelineStep(
                  icon: _steps[i].$2,
                  label: context.t(_steps[i].$1),
                  state: i < txn.done
                      ? _StepState.done
                      : (i == txn.done ? _StepState.now : _StepState.wait),
                  isLast: i == _steps.length - 1,
                ),
            ],
          ),
        ),
        if (txn.done < 6)
          AppButton(
            label: context.t('demo_next'),
            icon: Icons.fast_forward_rounded,
            color: Brand.green,
            onPressed: () => context.appRead.advance(txn),
          )
        else
          Center(
            child: StatusChip(context.t('all_done'), color: Brand.green),
          ),
        const SizedBox(height: 12),
      ],
    );
  }
}

enum _StepState { done, now, wait }

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({required this.icon, required this.label, required this.state, required this.isLast});
  final IconData icon;
  final String label;
  final _StepState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final done = state == _StepState.done;
    final now = state == _StepState.now;
    final color = done ? Brand.green : (now ? Brand.navy : Brand.border);
    final caption = done ? context.t('step_done') : (now ? context.t('step_now') : context.t('step_wait'));

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: done || now ? color : Brand.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(done ? Icons.check_rounded : icon,
                      size: 22, color: done || now ? Colors.white : Brand.muted),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 3, color: done ? Brand.green : Brand.border),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4, bottom: isLast ? 0 : 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: state == _StepState.wait ? Brand.muted : Brand.ink,
                      )),
                  const SizedBox(height: 2),
                  Text(caption, style: TextStyle(fontSize: 12, color: done ? Brand.green : Brand.muted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
