import 'dart:async';

import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:tally_client/tally_client.dart';

import '../client.dart';
import '../offline_queue.dart';
import 'bootstrap_screen.dart';
import 'deposit_screen.dart';
import 'ledger_screen.dart';
import 'rooms_screen.dart';

class DeskShell extends StatefulWidget {
  const DeskShell({super.key});

  @override
  State<DeskShell> createState() => _DeskShellState();
}

class _DeskShellState extends State<DeskShell> {
  Organization? _org;
  TodayTally? _tally;
  String? _error;
  bool _loading = true;
  int _tab = 0;
  StreamSubscription<TodayTally>? _sub;
  final _queue = OfflineDepositQueue();
  bool _offlineMode = false;
  bool _syncing = false;
  String? _statusBanner;
  ShiftJudgement? _judgement;

  @override
  void initState() {
    super.initState();
    _boot();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _boot() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final org = await client.organization.myOrganization();
      if (!mounted) return;
      if (org == null) {
        setState(() {
          _org = null;
          _loading = false;
        });
        return;
      }
      setState(() => _org = org);
      await _listenTally();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _listenTally() async {
    await _sub?.cancel();
    final first = await client.till.listToday();
    if (!mounted) return;
    setState(() {
      _tally = first;
      _loading = false;
    });
    _sub = client.till.watchToday().listen(
      (t) {
        if (!mounted) return;
        setState(() => _tally = t);
      },
      onError: (e) {
        if (!mounted) return;
        setState(() => _error = e.toString());
      },
    );
  }

  Future<void> _signOut() async {
    await _sub?.cancel();
    await client.auth.signOutDevice();
  }

  Future<void> _syncOffline() async {
    if (_queue.isEmpty) {
      setState(() => _statusBanner = 'Nothing queued offline.');
      return;
    }
    setState(() {
      _syncing = true;
      _statusBanner = null;
      _error = null;
    });
    try {
      final result = await client.till.syncOfflineDeposits(
        payloads: _queue.pending,
      );
      final syncedIds = result.accepted
          .map((d) => d.receiptCode)
          .toList(); // cosmetic
      _queue.clear();
      if (!mounted) return;
      setState(() {
        _tally = result.tally;
        _offlineMode = false;
        _statusBanner =
            'Synced ${result.accepted.length} deposit(s)'
            '${result.skippedMutationIds.isEmpty ? '' : ', skipped ${result.skippedMutationIds.length}'}'
            '${syncedIds.isEmpty ? '' : '.'}';
      });
    } on TillException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _judgeShift() async {
    setState(() {
      _statusBanner = null;
      _error = null;
    });
    try {
      final j = await client.till.judgeShift();
      if (!mounted) return;
      setState(() {
        _judgement = j;
        _statusBanner =
            'Jev shift: ${(j.healthyProbability * 100).toStringAsFixed(0)}% · ${j.recommendation}';
      });
    } on TillException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  Future<void> _scheduleClose() async {
    setState(() {
      _statusBanner = null;
      _error = null;
    });
    try {
      final id = await client.till.scheduleShiftClose(
        delaySeconds: 20,
        notes: 'Demo auto-close (free-plan delay).',
      );
      if (!mounted) return;
      setState(() {
        _statusBanner =
            'Auto-close scheduled ($id) — shift closes in ~20s (free plan).';
      });
    } on TillException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  String _ghs(double v) => 'GH₵${v.toStringAsFixed(2)}';

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null && _org == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_error!, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(onPressed: _boot, child: const Text('Retry')),
              ],
            ),
          ),
        ),
      );
    }
    if (_org == null) {
      return BootstrapScreen(onCreated: _boot);
    }

    final tally = _tally;
    final pages = [
      _Dashboard(
        org: _org!,
        tally: tally,
        formatGhs: _ghs,
        offlineMode: _offlineMode,
        queuedCount: _queue.length,
        judgement: _judgement,
        onRefresh: () async {
          final t = await client.till.listToday();
          if (mounted) setState(() => _tally = t);
        },
        onToggleOffline: () {
          setState(() {
            _offlineMode = !_offlineMode;
            _statusBanner = _offlineMode
                ? 'Offline mode ON — deposits queue locally until Sync.'
                : 'Online — deposits hit Serverpod immediately.';
          });
        },
        onSync: _syncOffline,
        syncing: _syncing,
        onJudge: _judgeShift,
        onScheduleClose: _scheduleClose,
      ),
      DepositScreen(
        rooms: tally?.rooms ?? const [],
        offlineMode: _offlineMode,
        queue: _queue,
        onQueued: () => setState(() {
          _statusBanner =
              'Queued ${_queue.length} offline deposit(s). Owner watch will not see them until Sync.';
        }),
        onDone: () async {
          final t = await client.till.listToday();
          if (mounted) setState(() => _tally = t);
          setState(() => _tab = 0);
        },
      ),
      RoomsScreen(
        rooms: tally?.rooms ?? const [],
        onChanged: () async {
          final t = await client.till.listToday();
          if (mounted) setState(() => _tally = t);
        },
      ),
      LedgerScreen(tally: tally, formatGhs: _ghs),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_offlineMode ? 'TALLY · OFFLINE' : 'TALLY'),
        actions: [
          if (_org != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  _org!.name,
                  style: const TextStyle(fontSize: 13, color: Color(0xFFD4AF37)),
                ),
              ),
            ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_offlineMode || _queue.isNotEmpty)
            Material(
              color: _offlineMode
                  ? const Color(0xFF7C2D12)
                  : const Color(0xFF1E3A5F),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      _offlineMode ? Icons.wifi_off : Icons.cloud_upload,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _offlineMode
                            ? 'Offline desk · ${_queue.length} queued'
                            : '${_queue.length} queued — tap Sync on Desk',
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                    if (_queue.isNotEmpty)
                      TextButton(
                        onPressed: _syncing ? null : _syncOffline,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: Text(_syncing ? 'Syncing…' : 'Sync now'),
                      ),
                  ],
                ),
              ),
            ),
          if (_statusBanner != null)
            Material(
              color: const Color(0xFFECFDF5),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _statusBanner!,
                  style: const TextStyle(color: Color(0xFF166534), fontSize: 13),
                ),
              ),
            ),
          if (_error != null)
            Material(
              color: const Color(0xFFFEF2F2),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Color(0xFF991B1B), fontSize: 13),
                ),
              ),
            ),
          Expanded(child: pages[_tab]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Desk',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            label: 'Deposit',
          ),
          NavigationDestination(
            icon: Icon(Icons.meeting_room_outlined),
            label: 'Rooms',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Ledger',
          ),
        ],
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({
    required this.org,
    required this.tally,
    required this.formatGhs,
    required this.offlineMode,
    required this.queuedCount,
    required this.judgement,
    required this.onRefresh,
    required this.onToggleOffline,
    required this.onSync,
    required this.syncing,
    required this.onJudge,
    required this.onScheduleClose,
  });

  final Organization org;
  final TodayTally? tally;
  final String Function(double) formatGhs;
  final bool offlineMode;
  final int queuedCount;
  final ShiftJudgement? judgement;
  final Future<void> Function() onRefresh;
  final VoidCallback onToggleOffline;
  final Future<void> Function() onSync;
  final bool syncing;
  final Future<void> Function() onJudge;
  final Future<void> Function() onScheduleClose;

  @override
  Widget build(BuildContext context) {
    final t = tally;
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Take deposit. Lock the night. Sync when MTN drops.',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '${org.name} · live watchToday stream · Jev room pick · future-call close.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black54,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.tonal(
                onPressed: onToggleOffline,
                child: Text(offlineMode ? 'Go online' : 'Simulate offline'),
              ),
              FilledButton.tonal(
                onPressed: syncing || queuedCount == 0 ? null : onSync,
                child: Text(syncing ? 'Syncing…' : 'Sync queue ($queuedCount)'),
              ),
              FilledButton.tonal(
                onPressed: offlineMode ? null : onJudge,
                child: const Text('Jev judge shift'),
              ),
              FilledButton.tonal(
                onPressed: offlineMode ? null : onScheduleClose,
                child: const Text('Schedule auto-close'),
              ),
            ],
          ),
          if (judgement != null) ...[
            const SizedBox(height: 12),
            Text(
              judgement!.recommendation,
              style: const TextStyle(fontSize: 13, color: Color(0xFF166534)),
            ),
          ],
          const SizedBox(height: 20),
          if (t == null)
            const Center(child: CircularProgressIndicator())
          else ...[
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _Metric(
                  label: "Today's total",
                  value: formatGhs(t.totalGhs),
                ),
                _Metric(
                  label: 'Deposits',
                  value: '${t.deposits.length}',
                ),
                _Metric(
                  label: 'Rooms locked',
                  value: '${t.occupiedCount}/${t.roomCount}',
                ),
                _Metric(
                  label: 'Shift',
                  value: t.shiftClosed ? 'Closed' : 'Open',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Recent deposits',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            if (t.deposits.isEmpty)
              const Text('No deposits yet today. Take the first one.')
            else
              ...t.deposits.take(8).map(
                    (d) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('${d.guestName} · Room deposit'),
                      subtitle: Text(
                        '${d.receiptCode} · ${d.method.name} · ${d.receptionistName}',
                      ),
                      trailing: Text(
                        formatGhs(d.amount),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
          ],
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E5E5)),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
