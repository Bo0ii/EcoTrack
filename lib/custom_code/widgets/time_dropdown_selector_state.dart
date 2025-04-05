// Automatic FlutterFlow imports
import '/backend/backend.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class TimeDropdownSelector extends StatefulWidget {
  final void Function(String, String)? onTimeChanged;

  const TimeDropdownSelector({
    Key? key,
    this.onTimeChanged,
  }) : super(key: key);

  @override
  _TimeDropdownSelectorState createState() => _TimeDropdownSelectorState();
}

class _TimeDropdownSelectorState extends State<TimeDropdownSelector> {
  final List<String> timeSlots = List.generate(
    48,
    (index) =>
        '${(index ~/ 2).toString().padLeft(2, '0')}:${(index % 2 == 0 ? '00' : '30')}',
  );

  String? startTime;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Turn On Time"),
        DropdownButton<String>(
          value: startTime,
          hint: const Text("Select Time"),
          isExpanded: true,
          items: timeSlots.map((time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Text(time),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => startTime = value);
            widget.onTimeChanged?.call(startTime ?? '', endTime ?? '');
          },
        ),
        const SizedBox(height: 16),
        const Text("Turn Off Time"),
        DropdownButton<String>(
          value: endTime,
          hint: const Text("Select Time"),
          isExpanded: true,
          items: timeSlots.map((time) {
            return DropdownMenuItem<String>(
              value: time,
              child: Text(time),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => endTime = value);
            widget.onTimeChanged?.call(startTime ?? '', endTime ?? '');
          },
        ),
      ],
    );
  }
}
