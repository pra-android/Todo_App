import 'package:todo_app/Widgets/DataBaseHandler.dart';
import 'package:todo_app/Widgets/Model.dart';
import 'package:todo_app/Widgets/Notificationsservices.dart';
import 'package:todo_app/Widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RFloatingActionButton extends StatefulWidget {
  final Future<void> func;
  RFloatingActionButton({required this.func});

  @override
  State<RFloatingActionButton> createState() => _RFloatingActionButtonState();
}

class _RFloatingActionButtonState extends State<RFloatingActionButton> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datetimecontroller = TextEditingController();

  List<Model> allmodels = [];
  DateTime selecteddate = DateTime.now();
  int dropdownvalue = 0;
  String todotaskstatusvalue = "Task NotCompleted";
  List<int> items = [0, 5, 10, 30];
  List<String> tasksstatus = ["Task Completed", "Task NotCompleted"];

  @override
  Widget build(BuildContext context) {
    void _selecteddate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2024),
          lastDate: DateTime(3000));
      if (pickedDate != null) {
        final pickedtime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.input);
        setState(() {
          selecteddate = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedtime!.hour, pickedtime.minute);
          print(selecteddate);
          print(selecteddate.runtimeType);
          var falseselectedate =
              DateFormat('yyyy-MM-dd HH:mm').format(selecteddate);
          print(falseselectedate);
          print(falseselectedate.runtimeType);
          selecteddate = DateTime.parse(falseselectedate);

          print(selecteddate);
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade500,
          title: const Text(
            "Add Todo Task",
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
                child: Card(
                  color: Colors.teal.shade500,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add the Task Accessories",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 7),
              CustomTextField(
                  hintText: "Enter the title", controller: titlecontroller),
              CustomTextField(
                  hintText: "Enter the descriptions",
                  controller: descriptioncontroller),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 50,
                width: Get.context!.width,
                child: Card(
                  color: Colors.teal.shade500,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "    Select Date and Time:",
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
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(selecteddate),
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          selecteddate;
                        });
                        _selecteddate(context);
                      },
                      icon: Icon(
                        Icons.calendar_month,
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 52,
                width: Get.context!.width,
                child: Card(
                  color: Colors.teal.shade500,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "   Assign Reminder Time if its your priority Task(Optional)",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
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
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Container(
                  height: 52,
                  width: Get.context!.width,
                  child: Card(
                    color: Colors.teal.shade500,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "   Task Status  (Required))",
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 16,
                  isExpanded: true,
                  value: todotaskstatusvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: tasksstatus
                      .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem(
                            value: e, child: Text(e.toString())),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      todotaskstatusvalue = val!;
                      print(dropdownvalue);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade500, elevation: 5),
                    onPressed: () async {
                      final title = titlecontroller.text;
                      final descriptions = descriptioncontroller.text;
                      final datetime = selecteddate;
                      final iscompleted =
                          todotaskstatusvalue == "Task NotCompleted"
                              ? false
                              : true;
                      print(datetime);
                      dropdownvalue;

                      if (title.isEmpty &&
                          descriptions.isEmpty &&
                          datetime == null &&
                          dropdownvalue == null) {
                        return;
                      } else {
                        final model = Model(
                          title: title,
                          descriptions: descriptions,
                          datetime: datetime,
                          imptaskearlier: dropdownvalue,
                          impdatetime: datetime
                              .subtract(Duration(minutes: dropdownvalue)),
                          iscompleted: iscompleted,
                        );

                        await DataBaseHandler.instance.insertdatas(model);

                        if (dropdownvalue == 0) {
                          NotificationService.showScheduledNotification(
                              title: title,
                              body: descriptions,
                              payload: "Reminder",
                              datetime: datetime);
                        } else {
                          NotificationService.scheduleimportanttask(
                              title: title,
                              body: descriptions,
                              datetime: datetime,
                              payload:
                                  "Reminder\t Important Task:\n${dropdownvalue} min left, So be Prepared\n Title:${title}\n Description:${descriptions}\n Time: ${datetime}",
                              impdatetime: datetime
                                  .subtract(Duration(minutes: dropdownvalue)));
                        }

                        titlecontroller.clear();

                        descriptioncontroller.clear();

                        allmodels =
                            await DataBaseHandler.instance.displaydatas();
                        Navigator.pop(context, allmodels);
                        setState(() {});
                        print("Data has been added successfully");
                        print(model);
                      }
                    },
                    child:
                        const Text("Confirm", style: TextStyle(fontSize: 16))),
              )
            ]),
          ),
        ));
  }
}
