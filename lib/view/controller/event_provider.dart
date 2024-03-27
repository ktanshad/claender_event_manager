import 'package:event_manager/view/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:mobkit_calendar/mobkit_calendar.dart';

class EventProvider extends ChangeNotifier {
  TextEditingController timeController = TextEditingController();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  String? selectedRepeat;
  List<MobkitCalendarAppointmentModel> eventList = [];



   // Delete ALLEventList
  void deleteAllEvents() async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('events');
    await eventBox.clear();
    eventList.clear();
    notifyListeners();
  }

  //add Event functions
  Future<void> addEvent(substractSelectedDate, selectedDate) async {
    Color eventColor;
    switch (selectedRepeat) {
      case "Daily":
        eventColor = Colors.blue;
        break;
      case "Weekly":
        eventColor = Colors.red;
        break;
      default:
        eventColor = Colors.black;
        break;
    }
    MobkitCalendarAppointmentModel newEvent =
        await MobkitCalendarAppointmentModel(
      title: eventTitleController.text,
      appointmentStartDate: substractSelectedDate,
      appointmentEndDate: substractSelectedDate,
      isAllDay: true,
      detail: DescriptionController.text,
      color: eventColor,
      recurrenceModel: _buildRecurrenceModel(
          selectedRepeat!, substractSelectedDate, selectedDate),
    );

    eventList.add(newEvent);

    notifyListeners();
    await addToHive();
    eventTitleController.text = "";
    DescriptionController.text = "";
    selectedRepeat = null;
    timeController.text = "";
  }

    //filter repeate type
  RecurrenceModel? _buildRecurrenceModel(
      String repeatOption, substractSelectedDate, selectedDate) {
    switch (repeatOption) {
      case "Daily":
        return RecurrenceModel(
            endDate: DateTime.now().add(const Duration(days: 365)),
            frequency: DailyFrequency(),
            interval: 365,
            repeatOf: 1);
      case "Monthly":
        return RecurrenceModel(
            endDate: DateTime.now().add(const Duration(days: 365)),
            frequency: MonthlyFrequency(
                monthlyFrequencyType:
                    DaysOfMonthModel(daysOfMonth: [selectedDate.day])),
            interval: 365,
            repeatOf: 0);
      case "Weekly":
        return RecurrenceModel(
          endDate: DateTime.now().add(const Duration(days: 365)),
          frequency: WeeklyFrequency(
            daysOfWeek: [selectedDate.weekday],
          ),
          interval: 365,
          repeatOf: 1,
        );
      default:
        return null;
    }
  }


   // Time Format
  String formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedTime = '$hour:${minute.toString().padLeft(2, '0')} $period';

    return formattedTime;
  }

  void setTimeController(String value) {
    timeController.text = value;
    notifyListeners();
  }

  //EventLists Add To Hive
  Future<void> addToHive() async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('events');
    List<EventModel> events = eventList.map((event) {
      return EventModel(
        title: event.title,
        appointmentStartDate: event.appointmentStartDate,
        appointmentEndDate: event.appointmentEndDate,
        isAllDay: event.isAllDay,
        detail: event.detail,
        repeatOption: selectedRepeat,
      );
    }).toList();
    await eventBox.addAll(events);
  }


  //assingn event List From Hive
  Future<void> assignEventListFromHive() async {
    final Box<EventModel> eventBox = await Hive.openBox<EventModel>('events');
    final List<EventModel> events = eventBox.values.toList();
    eventList = events.map((event) {
      Color eventColor;
      switch (event.repeatOption) {
        case "Daily":
          eventColor = Colors.blue;
          break;
        case "Weekly":
          eventColor = Colors.red;
          break;
        default:
          eventColor = Colors.black;
          break;
      }
      return MobkitCalendarAppointmentModel(
        title: event.title ?? '',
        appointmentStartDate: event.appointmentStartDate,
        appointmentEndDate: event.appointmentEndDate,
        isAllDay: event.isAllDay,
        detail: event.detail ?? '',
        color: eventColor, // Set appropriate color here
        recurrenceModel: _buildRecurrenceModel(event.repeatOption!,
            event.appointmentStartDate, event.appointmentEndDate),
      );
    }).toList();
  }

  notifyListeners();
}
