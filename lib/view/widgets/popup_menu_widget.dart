import 'package:event_manager/view/controller/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OnPopupWidget extends StatefulWidget {
  OnPopupWidget({
    super.key,
    required this.datetime,
    required this.models,
  });

  final DateTime datetime;
  final List<MobkitCalendarAppointmentModel> models;

  @override
  State<OnPopupWidget> createState() => _OnPopupWidgetState();
}

class _OnPopupWidgetState extends State<OnPopupWidget> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      child: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Center(
                  child: Text(
                "Event Details",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  DateFormat("EEE, MMMM d").format(widget.datetime),
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please Titile';
                      }
                    },
                    controller: eventProvider.eventTitleController,
                    decoration: const InputDecoration(
                      label: Text("Event Title"),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enterDescription';
                      }
                    },
                    controller: eventProvider.DescriptionController,
                    decoration: const InputDecoration(
                      label: Text("Event Description"),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      )),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select Time';
                      }
                    },
                    controller: eventProvider.timeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "Time", // Changed label to labelText
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      hintStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onTap: () async {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        String formattedTime =
                            eventProvider.formatTime(selectedTime);
                        eventProvider.setTimeController(formattedTime);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please select repeat';
                      }
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      errorStyle: TextStyle(color: Colors.red),
                      hintText: "Repeat",
                    ),
                    items: ["Daily", "Weekly", "Monthly"]
                        .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                    value: eventProvider.selectedRepeat,
                    dropdownColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        eventProvider.selectedRepeat = value;
                      });
                    },
                    // validator: validator,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        if (eventProvider.selectedRepeat != null &&
                            eventProvider
                                .eventTitleController.text.isNotEmpty &&
                            eventProvider.timeController.text.isNotEmpty) {
                          await eventProvider.addEvent(
                              widget.datetime.subtract(Duration(days: 1)),
                              widget.datetime);
                          Navigator.of(context).pop();
                        } else {
                          print('event add failds');
                        }
                      } else {
                        print('empty value');
                      }
                    },
                    child: Text("Save"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
