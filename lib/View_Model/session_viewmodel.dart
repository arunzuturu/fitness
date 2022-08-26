import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import '../Models/session_model.dart';

class ProgressController extends GetxController
{

  final now = DateTime.now();
  final bools = [false,false,false,false,false,false,false,false,false,false].obs;
  final count = 0.obs;
  final data = <Session>[].obs;
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
      var snapshot = event.snapshot;
      if(event.snapshot.key == date)
        {
          Iterable<DataSnapshot> children = snapshot.children;
          for (var element in children) {
            Session s = Session();
            s.timeStamp = element.key.toString();
            s.session = element.value.toString();
            data.add(s);
          }
          count.value = event.snapshot.children.length;
          count.refresh();
          for (int i=0; i<count.value; i++)
            {
              bools[i] = true;
            }
          print(event.snapshot.children.length);
        }
     });
   }



}

