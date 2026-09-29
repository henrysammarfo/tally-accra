import 'package:flutter/material.dart';
import 'package:tally_client/tally_client.dart';

import '../client.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key, required this.rooms, required this.onDone});

  final List<Room> rooms;
  final Future<void> Function() onDone;

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _guest = TextEditingController();
  final _phone = TextEditingController(text: '+233');
  final _amount = TextEditingController();
  String? _room;
  int _nights = 1;
  PaymentMethod _method = PaymentMethod.mtnMomo;
  CurrencyCode _currency = CurrencyCode.ghs;
  String? _error;
  String? _receipt;
  bool _busy = false;

  @override
  void dispose() {
    _guest.dispose();
    _phone.dispose();
    _amount.dispose();
    super.dispose();
  }

  List<Room> get _openRooms => widget.rooms
      .where(
        (r) =>
            r.status == RoomStatus.available ||
            r.status == RoomStatus.cleaning,
      )
      .toList();

  Future<void> _submit() async {
    final room = _room;
    final amount = double.tryParse(_amount.text.trim());
    if (room == null || amount == null) {
      setState(() => _error = 'Pick a room and enter a valid amount.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _receipt = null;
    });
    try {
      final deposit = await client.till.createDeposit(
        guestName: _guest.text,
        guestPhone: _phone.text,
        roomNumber: room,
        nights: _nights,
        amount: amount,
        currency: _currency,
        method: _method,
      );
      setState(() => _receipt = deposit.receiptCode);
      await widget.onDone();
    } on TillException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rooms = _openRooms;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          '8-second deposit',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 4),
        const Text('Name. Room. Money. Lock.'),
        const SizedBox(height: 20),
        TextField(
          controller: _guest,
          decoration: const InputDecoration(
            labelText: 'Guest full name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _phone,
          decoration: const InputDecoration(
            labelText: 'Phone (+233…)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          // ignore: deprecated_member_use
          value: _room,
          decoration: const InputDecoration(
            labelText: 'Room',
            border: OutlineInputBorder(),
          ),
          items: rooms
              .map(
                (r) => DropdownMenuItem(
                  value: r.number,
                  child: Text('${r.number} · ${r.type} · GH₵${r.rateGhs.toStringAsFixed(0)}'),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => _room = v),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                // ignore: deprecated_member_use
                value: _nights,
                decoration: const InputDecoration(
                  labelText: 'Nights',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (var i = 1; i <= 7; i++)
                    DropdownMenuItem(value: i, child: Text('$i')),
                ],
                onChanged: (v) => setState(() => _nights = v ?? 1),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _amount,
                decoration: const InputDecoration(
                  labelText: 'Deposit amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<PaymentMethod>(
          // ignore: deprecated_member_use
          value: _method,
          decoration: const InputDecoration(
            labelText: 'Payment',
            border: OutlineInputBorder(),
          ),
          items: PaymentMethod.values
              .map((m) => DropdownMenuItem(value: m, child: Text(m.name)))
              .toList(),
          onChanged: (v) => setState(() => _method = v ?? PaymentMethod.mtnMomo),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<CurrencyCode>(
          // ignore: deprecated_member_use
          value: _currency,
          decoration: const InputDecoration(
            labelText: 'Currency',
            border: OutlineInputBorder(),
          ),
          items: CurrencyCode.values
              .map((c) => DropdownMenuItem(value: c, child: Text(c.name.toUpperCase())))
              .toList(),
          onChanged: (v) => setState(() => _currency = v ?? CurrencyCode.ghs),
        ),
        if (_error != null) ...[
          const SizedBox(height: 12),
          Text(_error!, style: const TextStyle(color: Colors.red)),
        ],
        if (_receipt != null) ...[
          const SizedBox(height: 12),
          Text(
            'Locked. Receipt $_receipt',
            style: const TextStyle(
              color: Color(0xFF166534),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        const SizedBox(height: 20),
        FilledButton(
          onPressed: _busy || rooms.isEmpty ? null : _submit,
          child: Text(_busy ? 'Locking…' : 'Lock night & print receipt'),
        ),
      ],
    );
  }
}
