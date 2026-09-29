import 'package:flutter/material.dart';
import 'package:tally_client/tally_client.dart';

class LedgerScreen extends StatelessWidget {
  const LedgerScreen({
    super.key,
    required this.tally,
    required this.formatGhs,
  });

  final TodayTally? tally;
  final String Function(double) formatGhs;

  @override
  Widget build(BuildContext context) {
    final t = tally;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Daily ledger',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Live from Serverpod: createDeposit → assignNight → listToday.',
        ),
        const SizedBox(height: 16),
        if (t == null)
          const Center(child: CircularProgressIndicator())
        else ...[
          Text(
            'Close total ${formatGhs(t.totalGhs)} · ${t.deposits.length} deposits',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Text('Audit trail', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (t.auditTrail.isEmpty)
            const Text('No audit events yet today.')
          else
            ...t.auditTrail.map(
              (a) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(a.action),
                subtitle: Text(a.detail),
                trailing: Text(
                  a.createdAt.toLocal().toString().substring(11, 16),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
