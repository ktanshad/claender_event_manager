import 'package:hive/hive.dart';
part 'event_model.g.dart';

@HiveType(typeId: 0)
class EventModel extends HiveObject {
  @HiveField(0)
  String? nativeEventId;

  @HiveField(1)
  int? index;

  @HiveField(2)
  String? title;

  @HiveField(3)
  DateTime appointmentStartDate;

  @HiveField(4)
  DateTime appointmentEndDate;

  @HiveField(6)
  bool isAllDay;

  @HiveField(7)
  String detail;

  @HiveField(8)
  String? repeatOption;

  @HiveField(9)
  Object? eventData;

  EventModel({
    this.nativeEventId,
    this.index,
    this.title,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
    required this.isAllDay,
    required this.detail,
    required this.repeatOption,
    this.eventData,
  });
}
