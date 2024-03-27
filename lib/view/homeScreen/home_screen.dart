import 'package:event_manager/helpers/calender_configs.dart';
import 'package:event_manager/view/controller/event_provider.dart';
import 'package:event_manager/view/widgets/header_widget.dart';
import 'package:event_manager/view/widgets/popup_menu_widget.dart';
import 'package:event_manager/view/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    eventProvider.assignEventListFromHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Deletion"),
                    content:
                        Text("Are you sure you want to delete all events?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<EventProvider>(context, listen: false)
                              .deleteAllEvents();
                          Navigator.pop(context);
                        },
                        child: Text("Delete"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          padding: EdgeInsets.zero,
          tabs: const <Widget>[
            Tab(
              text: "Monthly",
            ),
            Tab(
              text: "Agenda",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Consumer<EventProvider>(
            builder: (context, eventProvider, child) {
              return MobkitCalendarWidget(
                minDate: DateTime(1800),
                key: UniqueKey(),
                config: getConfig(MobkitCalendarViewType.monthly),
                dateRangeChanged: (datetime) => null,
                headerWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    HeaderWidget(
                  datetime: datetime,
                  models: models,
                ),
                titleWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    TitleWidget(
                  datetime: datetime,
                  models: models,
                ),
                onSelectionChange: (List<MobkitCalendarAppointmentModel> models,
                        DateTime date) =>
                    null,
                eventTap: (model) => null,
                onPopupWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    OnPopupWidget(
                  datetime: datetime,
                  models: models,
                ),
                onDateChanged: (DateTime datetime) => null,
                mobkitCalendarController: MobkitCalendarController(
                  viewType: MobkitCalendarViewType.monthly,
                  appointmentList: eventProvider.eventList,
                ),
              );
            },
          ),
          Consumer<EventProvider>(
            builder: (context, eventProvider, child) {
              return MobkitCalendarWidget(
                minDate: DateTime(1800),
                key: UniqueKey(),
                config: getConfig(MobkitCalendarViewType.agenda),
                dateRangeChanged: (datetime) => null,
                headerWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    HeaderWidget(
                  datetime: datetime,
                  models: models,
                ),
                titleWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    TitleWidget(
                  datetime: datetime,
                  models: models,
                ),
                onSelectionChange: (List<MobkitCalendarAppointmentModel> models,
                        DateTime date) =>
                    null,
                eventTap: (model) => null,
                onPopupWidget: (List<MobkitCalendarAppointmentModel> models,
                        DateTime datetime) =>
                    OnPopupWidget(
                  datetime: datetime,
                  models: models,
                ),
                onDateChanged: (DateTime datetime) => null,
                mobkitCalendarController: MobkitCalendarController(
                  viewType: MobkitCalendarViewType.agenda,
                  appointmentList: eventProvider.eventList,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
