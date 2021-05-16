import 'package:flutter/material.dart';

import '../utils/date_time_format.dart';

class DateTimePickerWidget extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  VoidCallback selectDate;
  VoidCallback selectTime;

  DateTimePickerWidget({
    @required this.selectedDate,
    @required this.selectedTime,
    @required this.selectDate,
    @required this.selectTime,
  });

  @override
  _DateTimePickerWidgetState createState() => _DateTimePickerWidgetState();
}

class _DateTimePickerWidgetState extends State<DateTimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "Choose a delivery time at least 1 hour later than the current time",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildDateRowWidget(),
          SizedBox(
            height: 20,
          ),
          _buildTimeRowWidget()
        ],
      ),
    );
  }

  Row _buildDateRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 130,
          child: MaterialButton(
            onPressed: widget.selectDate,
            color: Colors.deepOrangeAccent,
            child: Text(
              "Select Date",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          "${DateTimeFormat.date(widget.selectedDate)}",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Row _buildTimeRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 50,
          width: 130,
          child: MaterialButton(
            onPressed: widget.selectTime,
            color: Colors.deepOrangeAccent,
            child: Text(
              "Select Time",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          "${DateTimeFormat.hours(widget.selectedTime.hour.toDouble())} ${widget.selectedTime.minute}m",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
