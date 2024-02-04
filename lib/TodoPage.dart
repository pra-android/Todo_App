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
        backgroundColor: Colors.deepPurple,
        actions: [
          CustomIconButton(
              icon: Icon(Icons.dark_mode),
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
        title: const Text(
          "Todo List Application",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAndDisplaySelection(context);
        },
        backgroundColor: Colors.deepPurple,
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
                                      funct: fetchmodelfromDatabase(),
                                      model: model)));
                          setState(() {
                            allmodels = results;
                          });
                        }

                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (index % 2 == 0)
                                  ? Colors.pink
                                  : Colors.deepPurple,
                            ),
                            height: 75,
                            child: ListTile(
                              leading: IconButton(
                                  onPressed: () {
                                    navigateandeditdatas(context);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                              title: Text(
                                model.title.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Column(
                                children: [
                                  Text(
                                    model.descriptions.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.alarm,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        DateFormat('yyyy-MM-dd h:mm:ss')
                                            .format(model.datetime!),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    deletedata(model.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
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
