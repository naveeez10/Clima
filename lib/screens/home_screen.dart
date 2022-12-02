import 'package:flutter/material.dart';
import 'package:weatherapp_starter_project/controllers/global_controller.dart';
import 'package:get/get.dart';
import 'header_widget.dart';
import 'package:weatherapp_starter_project/controllers/global_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController = Get.put(GlobalController(),permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(()=> globalController.isloading().isTrue ? const Center(
          child: CircularProgressIndicator(),
        ) : ListView(
          scrollDirection: Axis.vertical,
          children: [
            const SizedBox(
              height: 20,
            ),
            Headerwidget(),
          ],
        )),
      ),
    );
  }
}
