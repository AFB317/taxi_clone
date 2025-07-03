import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/functions.dart';
import '../../../../../utils/languages/constants.dart';
import '../../../../../utils/providers/text.dart';


class PickUpDatePicker extends StatefulWidget {
  const PickUpDatePicker({super.key});

  @override
  State<PickUpDatePicker> createState() => _PickUpDatePickerState();
}

class _PickUpDatePickerState extends State<PickUpDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dateTimePickerWidget();
      },
      child: Consumer<TextProvider>(
        builder: (context, provider, _) {
          return Card(
            shape: const StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: Row(
                children: [
                  const Icon(
                    MaterialCommunityIcons.calendar_clock,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    timeToDisplay(provider),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    size: 15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String timeToDisplay(TextProvider provider) {
    if (provider.dateTime != "0") {
      return provider.dateTime;
    } else {
      return "${getTranslated(context, 'pickup_now')}";
    }
  }

  _dateTimePickerWidget() {
    DateTime nowDate = DateTime.now();
    DateTime maxDate = DateTime(
      nowDate.year + 1,
      nowDate.month,
      nowDate.day,
    );
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM HH:mm',
      locale: DateTimePickerLocale.en_us,
      pickerTheme: DateTimePickerTheme(
        cancel: Text(
          "${getTranslated(context, 'cancel')}".toUpperCase(),
          style: const TextStyle(color: Colors.red),
        ),
        confirm: Text(
          "${getTranslated(context, 'confirm')}".toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      initialDateTime: DateTime.now().add(
        const Duration(
          hours: 1,
        ),
      ),
      minDateTime: DateTime.now().add(
        const Duration(
          hours: 1,
        ),
      ),
      maxDateTime: maxDate,
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        assignDate(dateTime);
        Provider.of<TextProvider>(context, listen: false).changeTime(
          time: customDateTime(dateTime),
        );
      },
    );
  }
}
