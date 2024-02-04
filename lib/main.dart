import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app/ThemeService.dart';
import 'package:todo_app/TodoPage.dart';
import 'package:todo_app/Widgets/Notificationsservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  NotificationService.init();
  tz.initializeTimeZones();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeService().theme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Color textColor = Colors.black.withOpacity(0.6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2 + 99,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(120)),
                  ),
                  child: Image.asset(
                    "assets/lamp.png",
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 17,
            ),
            Container(
              height: 286,
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(35))),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Increase your Productivity",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 19,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 51.0),
                    child: Text(
                      "Todo List application developed by Prabin Bhattarai on 14/01/2024.",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => TodoPage());
                    },
                    child: Container(
                      width: 232,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(
                          child: Text(
                        "Getting Started →→",
                        style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
