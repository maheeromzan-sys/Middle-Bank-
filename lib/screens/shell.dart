import 'package:flutter/material.dart';

import '../demo_data.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets.dart';
import 'support_screen.dart';
import 'track_screen.dart';

// ───────────────────────── helpers ─────────────────────────

Txn? pickCurrent(AppState app) => app.current ?? app.txns.firstOrNull;

Color statusColor(int done) =>
    done >= 6 ? Brand.green : (done <= 1 ? Brand.amber : Brand.navy);

void openTxn(BuildContext context, String route, {bool unpaid = false}) {
  final app = context.appRead;
  if (unpaid) {
    final t = app.txns.where((x) => !x.paid).firstOrNull;
    if (t != null) app.select(t);
  } else if (app.current == null && app.txns.isNotEmpty) {
    app.select(app.txns.first);
  }
  Navigator.pushNamed(context, route);
}

// ───────────────────────── shell with bottom navigation ─────────────────────────

class MainShell extends StatefulWidget {
  const MainShell({super.key, required this.seller});
  final bool seller;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _tab = 0;

  void _go(int i) => setState(() => _tab = i);

  @override
  Widget build(BuildContext context) {
    final seller = widget.seller;
    final pages = <Widget>[
      seller ? SellerHome(onTab: _go) : BuyerHome(onTab: _go),
      TabPage(
        title: seller ? context.t('incoming') : context.t('my_txns'),
        child: TxnList(seller: seller, mode: seller ? TxnMode.active : TxnMode.all),
      ),
      seller
          ? TabPage(title: context.t('history'), child: TxnList(seller: true, mode: TxnMode.done))
          : TabPage(title: context.t('track_txn'), child: const TrackBody()),
      TabPage(title: context.t('support'), child: const SupportBody()),
    ];

    return Scaffold(
      body: IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: _go,
        height: 68,
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), selectedIcon: const Icon(Icons.home_rounded), label: context.t('nav_home')),
          NavigationDestination(
            icon: Icon(seller ? Icons.move_to_inbox_outlined : Icons.swap_horiz_rounded),
            label: seller ? context.t('nav_incoming') : context.t('nav_txns'),
          ),
          NavigationDestination(
            icon: Icon(seller ? Icons.history_rounded : Icons.travel_explore_rounded),
            label: seller ? context.t('nav_history') : context.t('nav_track'),
          ),
          NavigationDestination(icon: const Icon(Icons.headset_mic_outlined), selectedIcon: const Icon(Icons.headset_mic_rounded), label: context.t('nav_support')),
        ],
      ),
    );
  }
}

/// Header + banner + body used by non-home tabs.
class TabPage extends StatelessWidget {
  const TabPage({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(gradient: Brand.navyGradient),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 16, 14),
              child: Row(
                children: [
                  const ShieldLogo(size: 26, onDark: true),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
                  ),
                  const LangSwitch(),
                ],
              ),
            ),
          ),
        ),
        const DemoBanner(),
        Expanded(child: child),
      ],
    );
  }
}

// ───────────────────────── dashboard header ─────────────────────────

class _DashHeader extends StatelessWidget {
  const _DashHeader({required this.title, required this.subtitle, required this.icon, required this.child});
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
      decoration: const BoxDecoration(
        gradient: Brand.navyGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const ShieldLogo(size: 28, onDark: true),
                  const SizedBox(width: 10),
                  const Expanded(child: Align(alignment: Alignment.centerLeft, child: BrandTitle(fontSize: 18, onDark: true))),
                  const LangSwitch(),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(icon, color: Brand.navy, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                      Text(subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white.withAlpha(210), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _GlassStat extends StatelessWidget {
  const _GlassStat({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: Brand.green, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withAlpha(215), fontSize: 12)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────── Buyer dashboard ─────────────────────────

class BuyerHome extends StatelessWidget {
  const BuyerHome({super.key, required this.onTab});
  final void Function(int) onTab;

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final held = app.txns
        .where((t) => t.done >= 2 && t.done <= 5)
        .fold<double>(0, (s, t) => s + t.amount);
    final recent = app.txns.take(3).toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _DashHeader(
          title: '${context.t('hello')}, ${app.userName}',
          subtitle: context.t('buyer_sub'),
          icon: Icons.person_rounded,
          child: _GlassStat(
            icon: Icons.shield_rounded,
            label: context.t('escrow_demo'),
            value: context.money(held),
          ),
        ),
        const DemoBanner(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActionGrid(tiles: [
                ActionTile(
                  icon: Icons.add_card_rounded,
                  label: context.t('new_txn'),
                  color: Brand.green,
                  onTap: () => Navigator.pushNamed(context, '/create'),
                ),
                ActionTile(
                  icon: Icons.swap_horiz_rounded,
                  label: context.t('my_txns'),
                  onTap: () => onTab(1),
                ),
                ActionTile(
                  icon: Icons.verified_user_rounded,
                  label: context.t('secure_payment'),
                  color: Brand.green,
                  onTap: () => openTxn(context, '/pay', unpaid: true),
                ),
                ActionTile(
                  icon: Icons.receipt_long_rounded,
                  label: context.t('txn_receipt'),
                  onTap: () => openTxn(context, '/receipt'),
                ),
                ActionTile(
                  icon: Icons.travel_explore_rounded,
                  label: context.t('track_txn'),
                  color: Brand.green,
                  onTap: () => onTab(2),
                ),
                ActionTile(
                  icon: Icons.headset_mic_rounded,
                  label: context.t('support'),
                  onTap: () => onTab(3),
                ),
              ]),
              const SizedBox(height: 18),
              SectionTitle(
                context.t('recent'),
                trailing: TextButton(onPressed: () => onTab(1), child: Text(context.t('view_all'))),
              ),
              if (recent.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(child: Text(context.t('no_txns'))),
                )
              else
                for (final t in recent) TxnTile(txn: t),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Seller dashboard ─────────────────────────

class SellerHome extends StatelessWidget {
  const SellerHome({super.key, required this.onTab});
  final void Function(int) onTab;

  @override
  Widget build(BuildContext context) {
    final app = context.app;
    final held = app.txns.where((t) => t.done >= 2 && t.done <= 5).fold<double>(0, (s, t) => s + t.amount);
    final released = app.txns.where((t) => t.done == 6).fold<double>(0, (s, t) => s + t.amount);
    final incoming = app.txns.where((t) => t.done < 6).take(3).toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _DashHeader(
          title: 'Rahim Traders',
          subtitle: context.t('seller_profile'),
          icon: Icons.storefront_rounded,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Brand.green, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified_rounded, color: Colors.white, size: 16),
                  const SizedBox(width: 6),
                  Text(context.t('verified_seller'),
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ),
        const DemoBanner(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment security status
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield_rounded, color: Brand.green, size: 28),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.t('pay_sec_status'),
                                  style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.navy)),
                              Text(context.t('all_secure'),
                                  style: const TextStyle(color: Brand.green, fontWeight: FontWeight.w700, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 22),
                    InfoRow(context.t('funds_held'), context.money(held), bold: true),
                    InfoRow(context.t('released_total'), context.money(released), bold: true, valueColor: Brand.green),
                  ],
                ),
              ),
              ActionGrid(columns: 2, tiles: [
                ActionTile(
                  icon: Icons.move_to_inbox_rounded,
                  label: context.t('incoming'),
                  onTap: () => onTab(1),
                ),
                ActionTile(
                  icon: Icons.local_shipping_rounded,
                  label: context.t('delivery_status'),
                  color: Brand.green,
                  onTap: () => openTxn(context, '/track'),
                ),
                ActionTile(
                  icon: Icons.history_rounded,
                  label: context.t('history'),
                  onTap: () => onTab(2),
                ),
                ActionTile(
                  icon: Icons.payments_rounded,
                  label: context.t('release_status'),
                  color: Brand.green,
                  onTap: () => openTxn(context, '/track'),
                ),
              ]),
              const SizedBox(height: 18),
              SectionTitle(
                context.t('incoming'),
                trailing: TextButton(onPressed: () => onTab(1), child: Text(context.t('view_all'))),
              ),
              if (incoming.isEmpty)
                Padding(padding: const EdgeInsets.all(24), child: Center(child: Text(context.t('no_txns'))))
              else
                for (final t in incoming) TxnTile(txn: t, seller: true),
            ],
          ),
        ),
      ],
    );
  }
}

// ───────────────────────── Transaction list + tile ─────────────────────────

enum TxnMode { all, active, done }

class TxnList extends StatelessWidget {
  const TxnList({super.key, required this.seller, required this.mode});
  final bool seller;
  final TxnMode mode;

  @override
  Widget build(BuildContext context) {
    final all = context.app.txns;
    final list = all.where((t) {
      switch (mode) {
        case TxnMode.all:
          return true;
        case TxnMode.active:
          return t.done < 6;
        case TxnMode.done:
          return t.done == 6;
      }
    }).toList();

    if (list.isEmpty) {
      return Center(child: Text(context.t('no_txns')));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [for (final t in list) TxnTile(txn: t, seller: seller)],
    );
  }
}

class TxnTile extends StatelessWidget {
  const TxnTile({super.key, required this.txn, this.seller = false});
  final Txn txn;
  final bool seller;

  @override
  Widget build(BuildContext context) {
    final color = statusColor(txn.done);
    String? actionLabel;
    if (seller) {
      if (txn.done == 2) actionLabel = context.t('mark_shipped');
      if (txn.done == 3) actionLabel = context.t('mark_delivered');
    }
    return AppCard(
      onTap: () {
        context.appRead.select(txn);
        Navigator.pushNamed(context, '/track');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: Brand.lightBlue, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.inventory_2_rounded, color: Brand.navy),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(txn.product,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(context.n(txn.id), style: const TextStyle(fontSize: 12, color: Brand.muted)),
                  ],
                ),
              ),
              Text(context.money(txn.amount),
                  style: const TextStyle(fontWeight: FontWeight.w800, color: Brand.navy, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Flexible(child: StatusChip(context.t(txn.statusKey), color: color)),
              const Spacer(),
              Text(context.date(txn.createdAt), style: const TextStyle(fontSize: 11, color: Brand.muted)),
            ],
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Brand.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                ),
                onPressed: () => context.appRead.advance(txn),
                child: Text(actionLabel,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            ),
          ] else if (seller && txn.done < 6) ...[
            const SizedBox(height: 8),
            Text(
              txn.done == 1 ? context.t('awaiting_pay') : (txn.done == 4 ? context.t('awaiting_buyer') : context.t('ready_release')),
              style: const TextStyle(fontSize: 12, color: Brand.muted),
            ),
          ],
        ],
      ),
    );
  }
}
