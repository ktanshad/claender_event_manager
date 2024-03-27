

import 'package:event_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_calendar/mobkit_calendar.dart';

MobkitCalendarConfigModel getConfig(
      MobkitCalendarViewType mobkitCalendarViewType) {
    return MobkitCalendarConfigModel(
      cellConfig: CalendarCellConfigModel(
        disabledStyle: CalendarCellStyle(
          textStyle:
              TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.5)),
          color: Colors.transparent,
        ),
        enabledStyle: CalendarCellStyle(
          textStyle: const TextStyle(fontSize: 14, color: Colors.black),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        selectedStyle: CalendarCellStyle(
          color: Colors.orange,
          textStyle: const TextStyle(fontSize: 14, color: Colors.white),
          border: Border.all(color: Colors.black, width: 1),
        ),
        currentStyle: CalendarCellStyle(
          textStyle: const TextStyle(color: Colors.lightBlue),
        ),
      ),
      calendarPopupConfigModel: CalendarPopupConfigModel(
        popUpBoxDecoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        popUpOpacity: true,
        animateDuration: 500,
        verticalPadding: 30,
        popupSpace: 10,
         popupHeight: pageHeight * 0.6,
        popupWidth: pageWidht,
        viewportFraction: 0.9,
      ),
      topBarConfig: CalendarTopBarConfigModel(
        isVisibleHeaderWidget:
            mobkitCalendarViewType == MobkitCalendarViewType.monthly ||
                mobkitCalendarViewType == MobkitCalendarViewType.agenda,
        isVisibleTitleWidget: true,
        isVisibleMonthBar: false,
        isVisibleYearBar: false,
        isVisibleWeekDaysBar: true,
        weekDaysStyle: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      weekDaysBarBorderColor: Colors.transparent,
      locale: "en",
      disableOffDays: true,
      disableWeekendsDays: false,
      monthBetweenPadding: 20,
      primaryColor: Colors.lightBlue,
      popupEnable: mobkitCalendarViewType == MobkitCalendarViewType.monthly
          ? true
          : false,
    );
  }
