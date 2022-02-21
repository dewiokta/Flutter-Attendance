import 'package:flutter/material.dart';
import 'package:flutter_attendance/components/rounded_button.dart';
import 'package:flutter_attendance/constants.dart';

class DatePickerWidget extends StatefulWidget {
  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime(2022, 2, 15), end: DateTime(2022, 3, 15));
  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Presensi"),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RoundedButton(
                          text: '${start.year}/${start.month}/${start.day}',
                          press: pickDate),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: RoundedButton(
                          text: '${end.year}/${end.month}/${end.day}',
                          press: pickDate),
                    ),
                  ],
                ),
                
                Row(
                  children: const [
                    Text(
                      "Detail Riwayat Mingguan",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future pickDate() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (newDateRange == null) return; //press X

    setState(() => dateRange = newDateRange);
  }
}
