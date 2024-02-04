import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Widgets/DataBaseHandler.dart';
import 'package:todo_app/Widgets/Model.dart';
import 'package:todo_app/Widgets/Notificationsservices.dart';
import 'package:todo_app/Widgets/TextField.dart';

class UpdateDate extends StatefulWidget {
  final Future<void> funct;
  final Model model;

  UpdateDate({required this.funct, required this.model});

  @override
  State<UpdateDate> createState() => _UpdateDateState();
}

class _UpdateDateState extends State<UpdateDate> {
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController descriptioncontroller = TextEditingController();

  TextEditingController datetimecontroller = TextEditingController();

  List<Model> allmodels = [];

  DateTime selecteddate = DateTime.now();

  int dropdownvalue = 0;

  List<int> items = [0, 5, 10, 30];

  @override
  Widget build(BuildContext context) {
    void _selecteddate(BuildContext context) async {
      final pickeddate = await showDatePicker(
          context: context,
          initialDate: selecteddate,
          firstDate: DateTime(2024),
          lastDate: DateTime(2028));

      if (pickeddate != null) {
        final pickedtime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input);
        setState(() {
          selecteddate = DateTime(pickeddate.year, pickeddate.month,
              pickeddate.day, pickedtime!.hour, pickedtime.minute);

          var falseselectedate = selecteddate.toString();
          selecteddate = DateFormat('yyyy-MM-dd h:mm').parse(falseselectedate);

          print(selecteddate);
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            "Update Todo Task",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(children: [
            const SizedBox(height: 5),
            Container(
              height: 50,
              width: Get.context!.width,
              child: const Card(
                color: Colors.deepPurple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit the Task Accessories",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
                hintText: "Edit the title", controller: titlecontroller),
            CustomTextField(
                hintText: "Enter the descriptions",
                controller: descriptioncontroller),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              width: Get.context!.width,
              child: const Card(
                color: Colors.deepPurple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Selected Date and Time:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(DateFormat('yyyy-MM-dd h:mm').format(selecteddate)),
                IconButton(
                    onPressed: () {
                      _selecteddate(context);
                    },
                    icon: Icon(Icons.calendar_month))
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 52,
              width: Get.context!.width,
              child: const Card(
                color: Colors.deepPurple,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Assign Reminder Time if its your priority Task(Optional)",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<int>(
                borderRadius: BorderRadius.circular(5),
                elevation: 16,
                isExpanded: true,
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items
                    .map<DropdownMenuItem<int>>(
                      (int e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.toString() + "  min",
                          )),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    dropdownvalue = val!;
                    print(dropdownvalue);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 48,
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      onPressed: () async {
                        final title = titlecontroller.text;
                        final description = descriptioncontroller.text;
                        final datetime = selecteddate;
                        dropdownvalue;
                        if (title.isNotEmpty &&
                            description.isNotEmpty &&
                            datetime == null) {
                          return;
                        } else {
                          widget.model.title = title;
                          widget.model.descriptions = description;
                          widget.model.datetime = datetime;
                          widget.model.impdatetime = datetime
                              .subtract(Duration(minutes: dropdownvalue));
                          DataBaseHandler.instance.updatedatas(widget.model);
                          NotificationService.showScheduledNotification(
                              title: widget.model.title!,
                              body: widget.model.descriptions!,
                              id: 1,
                              datetime: widget.model.datetime!);
                          NotificationService.scheduleimportanttask(
                              title: widget.model.title!,
                              body: widget.model.descriptions!,
                              datetime: widget.model.datetime!,
                              payload:
                                  "Reminder\t Important Task:\n${dropdownvalue} min left, So be Prepared\n Title:${widget.model.title}\n Description:${widget.model.descriptions}\n Time: ${widget.model.datetime}",
                              impdatetime: widget.model.datetime!
                                  .subtract(Duration(minutes: dropdownvalue)));
                          widget.funct;

                          descriptioncontroller.clear();
                          titlecontroller.clear();
                          allmodels =
                              await DataBaseHandler.instance.displaydatas();
                          Navigator.pop(context, allmodels);

                          setState(() {});
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ])),
        ));
  }
}
