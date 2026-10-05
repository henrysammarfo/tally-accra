import 'package:tally_client/tally_client.dart';

/// In-memory offline deposit queue for Accra desk (airplane-mode demo).
class OfflineDepositQueue {
  final List<OfflineDepositPayload> _pending = [];

  List<OfflineDepositPayload> get pending => List.unmodifiable(_pending);

  int get length => _pending.length;

  bool get isEmpty => _pending.isEmpty;

  bool get isNotEmpty => _pending.isNotEmpty;

  void enqueue(OfflineDepositPayload payload) {
    _pending.add(payload);
  }

  void clear() => _pending.clear();

  void removeAll(Iterable<String> mutationIds) {
    final ids = mutationIds.toSet();
    _pending.removeWhere((p) => ids.contains(p.clientMutationId));
  }

  static String newMutationId() {
    final stamp = DateTime.now().toUtc().microsecondsSinceEpoch;
    final salt = stamp.hashCode.toRadixString(16);
    return 'off-$stamp-$salt';
  }
}
