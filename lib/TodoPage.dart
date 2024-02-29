import 'package:todo_app/CreateData.dart';
import 'package:todo_app/ThemeService.dart';
import 'package:todo_app/UpdateData.dart';
import 'package:todo_app/Widgets/DataBaseHandler.dart';
import 'package:todo_app/Widgets/IconButton.dart';
import 'package:todo_app/Widgets/Model.dart';
import 'package:todo_app/Widgets/Notificationsservices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datetimecontroller = TextEditingController();

  List<Model> allmodels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchmodelfromDatabase();
  }

  Future<void> fetchmodelfromDatabase() async {
    List<Model> model = await DataBaseHandler.instance.displaydatas();
    setState(() {
      allmodels = model;
    });
  }

  DateTime selecteddate = DateTime.now();

  @override
  int dropdownvalue = 0;
  List<int> items = [0, 5, 10, 30];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal.shade500,
        actions: [
          CustomIconButton(
              icon: Icon(
                Icons.dark_mode,
                color: Colors.white,
              ),
              press: () {
                ThemeService().switchtheme();
                NotificationService.showNotification(
                    title: "Theme Update",
                    body: "Successfully updated the desired theme");
              }),
          CustomIconButton(
            icon: const Icon(
              Icons.share_rounded,
              color: Colors.white,
            ),
            press: () {
              Share.share(
                  "Hi, download this app from https://play.google.com/store/apps/details?id=com.tencent.ig ");
            },
          ),
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Todo List Application",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        backgroundColor: Colors.teal.shade500,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          allmodels.length == 0
              ? Center(child: Text("No data Found"))
              : Expanded(
                  child: ListView.builder(
                      itemCount: allmodels.length,
                      itemBuilder: (context, index) {
                        final model = allmodels[index];

                        Future<void> navigateandeditdatas(
                            BuildContext context) async {
                          final results = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateDate(
                                      initialtitle: model.title!,
                                      initialdescriptions: model.descriptions!,
                                      iscompleted: model.iscompleted,
                                      imptaskearlier: model.imptaskearlier,
                                      initialdatetime:
                                          model.datetime!.toString(),
                                      funct: fetchmodelfromDatabase(),
                                      model: model)));
                          setState(() {
                            allmodels = results;
                          });
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 7.0, right: 7.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: (model.iscompleted)
                                    ? Colors.grey.shade300
                                    : Colors.teal.shade500,
                              ),
                              height: 85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          model.iscompleted
                                              ? const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child:
                                                      Icon(Icons.check_circle),
                                                )
                                              : Text(""),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(model.title.toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: model.iscompleted
                                                        ? Colors.black
                                                        : Colors.white,
                                                    decorationColor:
                                                        Colors.white,
                                                    decorationThickness:
                                                        model.iscompleted
                                                            ? 3
                                                            : 0,
                                                    decoration: model
                                                            .iscompleted
                                                        ? TextDecoration.none
                                                        : TextDecoration.none)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 12.0),
                                                child: Icon(
                                                  Icons.alarm,
                                                  color: model.iscompleted
                                                      ? Colors.black
                                                      : Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                                DateFormat('HH:mm:a')
                                                    .format(model.datetime!),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: model.iscompleted
                                                        ? Colors.black
                                                        : Colors.white,
                                                    decorationColor:
                                                        Colors.white,
                                                    decorationThickness:
                                                        model.iscompleted
                                                            ? 3
                                                            : 0,
                                                    decoration: model
                                                            .iscompleted
                                                        ? TextDecoration.none
                                                        : TextDecoration.none)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                            model.descriptions.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                decorationColor: Colors.white,
                                                color: model.iscompleted
                                                    ? Colors.black
                                                    : Colors.white,
                                                decorationThickness:
                                                    model.iscompleted ? 3 : 0,
                                                decoration: model.iscompleted
                                                    ? TextDecoration.none
                                                    : TextDecoration.none)),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "Features",
                                          style: TextStyle(
                                              color: model.iscompleted
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontSize: 14,
                                              decorationColor: Colors.white,
                                              decorationThickness:
                                                  model.iscompleted ? 3 : 0,
                                              decoration: model.iscompleted
                                                  ? TextDecoration.none
                                                  : TextDecoration.none),
                                        ),
                                      ),
                                      Row(children: [
                                        IconButton(
                                            onPressed: () {
                                              navigateandeditdatas(context);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: model.iscompleted
                                                  ? Colors.black
                                                  : Colors.white,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              deletedata(model.id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: model.iscompleted
                                                  ? Colors.black
                                                  : Colors.white,
                                            )),
                                      ]),
                                    ],
                                  ),
                                ],
                              )),
                        );
                      }),
                ),
        ],
      ),
    );
  }

  void deletedata(int? id) async {
    await DataBaseHandler.instance.deletedata(id!);
    fetchmodelfromDatabase();
    setState(() {});
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RFloatingActionButton(func: fetchmodelfromDatabase())));
    setState(() {
      allmodels = result;
      ;
    });
  }
}
