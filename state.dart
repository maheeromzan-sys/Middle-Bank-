import 'package:flutter/material.dart';

import 'demo_data.dart';
import 'strings.dart';

/// App-wide in-memory state (language, role, demo transactions).
class AppState extends ChangeNotifier {
  bool bangla = true; // default language: Bangla
  bool isSeller = false;
  String userName = 'Demo User';
  String userMobile = '01800-000000';
  final List<Txn> txns = Txn.samples();
  Txn? current;
  int _seq = 1042;

  void setBangla(bool v) {
    if (bangla == v) return;
    bangla = v;
    notifyListeners();
  }

  void setSeller(bool v) {
    isSeller = v;
    notifyListeners();
  }

  void setProfile(String name, String mobile) {
    userName = name;
    userMobile = mobile;
    notifyListeners();
  }

  String newTxnId() => 'MB-2026-${(_seq + 1).toString().padLeft(6, '0')}';

  void add(Txn t) {
    _seq++;
    txns.insert(0, t);
    current = t;
    notifyListeners();
  }

  void select(Txn t) {
    current = t;
    notifyListeners();
  }

  void advance(Txn t) {
    if (t.done < 6) {
      t.done++;
      notifyListeners();
    }
  }

  void touch() => notifyListeners();
}

class AppScope extends InheritedNotifier<AppState> {
  AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);
}

extension L10n on BuildContext {
  /// Reactive access (rebuilds the widget when state changes). Use in build().
  AppState get app => dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;

  /// Non-reactive access. Use inside callbacks.
  AppState get appRead =>
      getInheritedWidgetOfExactType<AppScope>()!.notifier!;

  String t(String key) {
    final v = kStrings[key];
    if (v == null) return key;
    return app.bangla ? v[1] : v[0];
  }

  /// Converts digits to Bangla digits when the language is Bangla.
  String n(Object value) {
    final s = value.toString();
    if (!app.bangla) return s;
    const bn = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return s.replaceAllMapped(RegExp(r'\d'), (m) => bn[int.parse(m[0]!)]);
  }

  String money(num v) {
    final s = v.round().toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return '৳ ${n(buf)}';
  }

  String date(DateTime d) {
    const en = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const bn = [
      'জানু', 'ফেব্রু', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
      'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
    ];
    String two(int v) => v.toString().padLeft(2, '0');
    final h12 = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final pm = d.hour >= 12;
    final ap = app.bangla ? (pm ? 'অপরাহ্ণ' : 'পূর্বাহ্ণ') : (pm ? 'PM' : 'AM');
    final m = (app.bangla ? bn : en)[d.month - 1];
    return n('${d.day} $m ${d.year}, ${two(h12)}:${two(d.minute)}') + ' $ap';
  }
}
