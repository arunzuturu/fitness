import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ProgressController extends GetxController
{
  final now = DateTime.now();
  final count = 0.obs;

   @override
   void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCount();
  }
   void getCount()
   {
     String date = now.toString().substring(0,10);
     final fb = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://fitness-87807-default-rtdb.asia-southeast1.firebasedatabase.app");
     var Ref = fb.ref("sessions");

    Ref.onChildAdded.listen((event) {
       count.value = event.snapshot.children.length;
       // count.refresh();
       print(count.value);
     });
   }
}