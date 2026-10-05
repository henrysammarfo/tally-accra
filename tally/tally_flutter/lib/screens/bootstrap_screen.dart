import 'package:flutter/material.dart';
import 'package:tally_client/tally_client.dart';

import '../client.dart';

class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen({super.key, required this.onCreated});

  final Future<void> Function() onCreated;

  @override
  State<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  final _name = TextEditingController(text: 'Osu Heritage Suites');
  final _slug = TextEditingController(text: 'osu-heritage');
  final _display = TextEditingController(text: 'Akosua');
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _name.dispose();
    _slug.dispose();
    _display.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await client.organization.bootstrapGuestHouse(
        name: _name.text,
        slug: _slug.text,
        displayName: _display.text,
      );
      await widget.onCreated();
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
    return Scaffold(
      appBar: AppBar(title: const Text('TALLY')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Open your guest-house till',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Creates your Accra property, owner seat, and rooms 101–108 on Serverpod.',
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Guest-house name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _slug,
                  decoration: const InputDecoration(
                    labelText: 'Slug',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _display,
                  decoration: const InputDecoration(
                    labelText: 'Your desk name',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: _busy ? null : _submit,
                  child: Text(_busy ? 'Creating…' : 'Create till'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
