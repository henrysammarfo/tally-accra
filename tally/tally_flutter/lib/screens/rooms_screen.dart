import 'package:flutter/material.dart';
import 'package:tally_client/tally_client.dart';

import '../client.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key, required this.rooms, required this.onChanged});

  final List<Room> rooms;
  final Future<void> Function() onChanged;

  Future<void> _toggle(BuildContext context, Room room) async {
    final lock = room.status == RoomStatus.available ||
        room.status == RoomStatus.cleaning;
    try {
      await client.till.assignNight(roomNumber: room.number, lock: lock);
      await onChanged();
    } on TillException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Rooms & nights',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 12),
        ...rooms.map(
          (room) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFE5E5E5)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListTile(
              title: Text('${room.number} · ${room.type}'),
              subtitle: Text(
                [
                  'GH₵${room.rateGhs.toStringAsFixed(0)}/night',
                  room.status.name,
                  if (room.guestName != null) room.guestName!,
                ].join(' · '),
              ),
              trailing: TextButton(
                onPressed: () => _toggle(context, room),
                child: Text(
                  room.status == RoomStatus.available ||
                          room.status == RoomStatus.cleaning
                      ? 'Lock'
                      : 'Free',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
