import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Models/session_model.dart';


class ProgressController extends GetxController
{
  final fb = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://fitness-87807-default-rtdb.asia-southeast1.firebasedatabase.app");
  final index = 1.obs;
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
     var Ref = fb.ref("sessions");
    Ref.onChildAdded.listen((event) {
      var snapshot = event.snapshot;
      if(event.snapshot.key == date)
        {
          count.value = event.snapshot.children.length;
          count.refresh();
          for (int i=0; i<count.value; i++)
            {
              bools[i] = true;
            }
          Iterable<DataSnapshot> children = snapshot.children;
          for (var element in children) {
            Session s = Session();
            s.timeStamp = element.key.toString();
            s.session = element.value.toString();
            data.add(s);
          }
        }
     });
   }

  Future<void> addSession() async {
    final present = DateTime.now();
    String formatter = present.toString().substring(0, 10);
    String time = DateFormat.jm().format(present);
    var ref = fb.ref('sessions/$formatter/$time');
    if(data.isEmpty)
      {
        await ref.set("Session ${index.value}");
        index.value+=1;
      }
    else if(data[index.value-1].timeStamp != time)
      {
        await ref.set("Session ${index.value}");
        index.value+=1;
      }

  }

}

