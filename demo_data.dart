/// Simulated transaction model. All data here is demo data only.
class Txn {
  Txn({
    required this.id,
    required this.product,
    required this.seller,
    required this.sellerPhone,
    required this.buyer,
    required this.buyerPhone,
    required this.amount,
    required this.delivery,
    required this.createdAt,
    this.done = 1,
    this.method,
  });

  final String id;
  final String product;
  final String seller;
  final String sellerPhone;
  final String buyer;
  final String buyerPhone;
  final double amount;
  final String delivery;
  final DateTime createdAt;

  /// Number of completed tracking steps (1..6):
  /// 1 created, 2 payment confirmed, 3 shipped, 4 delivered,
  /// 5 buyer confirmed, 6 payment released.
  int done;
  String? method;

  bool get paid => done >= 2;

  String get statusKey => const [
        'st_wait_pay',
        'st_wait_pay',
        'st_held',
        'st_shipped',
        'st_delivered',
        'st_buyer_ok',
        'st_released',
      ][done];

  static List<Txn> samples() => [
        Txn(
          id: 'MB-2026-001042',
          product: 'Samsung Galaxy A15 (Used)',
          seller: 'Rahim Traders',
          sellerPhone: '01711-000001',
          buyer: 'Karim Ahmed',
          buyerPhone: '01811-000002',
          amount: 18500,
          delivery: 'House 12, Road 4, Rajshahi',
          createdAt: DateTime(2026, 11, 10, 14, 30),
          done: 3,
          method: 'method_partner',
        ),
        Txn(
          id: 'MB-2026-001041',
          product: 'Cotton Three-Piece Set',
          seller: 'Nila Fashion',
          sellerPhone: '01911-000003',
          buyer: 'Karim Ahmed',
          buyerPhone: '01811-000002',
          amount: 3200,
          delivery: 'House 12, Road 4, Rajshahi',
          createdAt: DateTime(2026, 11, 8, 11, 5),
          done: 6,
          method: 'method_wallet',
        ),
        Txn(
          id: 'MB-2026-001040',
          product: 'Bluetooth Headphones',
          seller: 'Gadget Hub',
          sellerPhone: '01611-000004',
          buyer: 'Karim Ahmed',
          buyerPhone: '01811-000002',
          amount: 2450,
          delivery: 'House 12, Road 4, Rajshahi',
          createdAt: DateTime(2026, 11, 12, 9, 15),
          done: 1,
        ),
      ];
}
