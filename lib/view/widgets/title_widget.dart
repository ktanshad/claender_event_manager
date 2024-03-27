import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';
import 'package:intl/intl.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.datetime,
    required this.models,
  });

  final DateTime datetime;
  final List<MobkitCalendarAppointmentModel> models;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(children: [
        Text(
          DateFormat("yyyy MMMM").format(datetime),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ]),
    );
  }
}
