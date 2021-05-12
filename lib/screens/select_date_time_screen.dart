import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'cart_screen.dart';
import '../utils/date_time_format.dart';
import '../widgets/date_time_picker_widget.dart';

class SelectDateTime extends StatefulWidget {
  const SelectDateTime({
    @required this.itemName,
    @required this.itemImage,
    @required this.price,
  });

  final dynamic itemName;
  final dynamic itemImage;
  final dynamic price;

  @override
  _SelectDateTimeState createState() => _SelectDateTimeState();
}

class _SelectDateTimeState extends State<SelectDateTime> {
  static DateTime selectedDate = DateTime.now();
  static TimeOfDay selectedTime = TimeOfDay.now();
  var myDateFormat = DateFormat('d-MM-yyyy');
  var myTimeFormat = TimeOfDay.fromDateTime(selectedDate);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select pick-up data and time"),
        centerTitle: true,
      ),
      body: DateTimePickerWidget(
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        selectDate: _selectDate,
        selectTime: _selectTime,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          print("tapped");
          cart.addItem(
            widget.itemName,
            widget.itemImage,
            widget.price,
            "${DateTimeFormat.date(selectedDate)}",
            "${DateTimeFormat.hours(selectedTime.hour.toDouble())} ${selectedTime.minute}m",
          );
          print("tapped");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(),
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay.now().replacing(hour: TimeOfDay.now().hourOfPeriod),
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}
