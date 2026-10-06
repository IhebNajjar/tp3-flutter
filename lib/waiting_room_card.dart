import 'package:flutter/material.dart';
import 'package:waiting_room_app/waiting_room_timestamp.dart';

class WaitingRoomCard extends StatefulWidget {
  final String name;

  const WaitingRoomCard({super.key, required this.name});

  @override
  State<WaitingRoomCard> createState() => _WaitingRoomCardState();
}

class _WaitingRoomCardState extends State<WaitingRoomCard> {
  bool _isHighlighted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isHighlighted = !_isHighlighted;
        });
      },
      child: Card(
        color: _isHighlighted ? Colors.lightBlueAccent : null,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Hello,',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const WaitingRoomTimestamp(),
          ],
        ),
      ),
      ),
    );
  }
}