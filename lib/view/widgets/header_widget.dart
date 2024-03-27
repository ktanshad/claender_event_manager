import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
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
          DateFormat("MMMM").format(datetime),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ]),
    );
  }
}
