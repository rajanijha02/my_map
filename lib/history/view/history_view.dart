import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_map/history/controller/history_controller.dart';
import 'package:my_map/model/history_model.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 21, 73),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'History',
          style: GoogleFonts.firaSans(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              )
            : controller.history.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No Data Found',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          LocationHistory locationHistory =
                              controller.history[index];
                          Get.toNamed(
                            '/maphistory',
                            arguments: locationHistory,
                          );
                        },
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              controller.history[index].date ?? 'NOT_FOUND',
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              'Total Location Count: ${controller.history[index].location}',
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.history.length,
                  );
      }),
    );
  }
}
/**
 * for(var index = 0; index<10; index++){
 *  console.log(index);
 * }
 */
