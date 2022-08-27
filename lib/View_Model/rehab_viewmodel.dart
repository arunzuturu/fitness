import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/Models/session_model.dart';
import 'package:get/get.dart';

class RehabController extends GetxController
{
  final now = DateTime.now();
  final fb = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://fitness-87807-default-rtdb.asia-southeast1.firebasedatabase.app");
  final sessions = <Session>[].obs;
  final totalsessions = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }
  void getData()
  {
    var Ref = fb.ref("sessions");
    Ref.onValue.listen((event){
      String date = now.toString().substring(0,10);
      var snapshot = event.snapshot;
      Iterable<DataSnapshot> children = snapshot.children;
      for( var k in children)
        {
          sessions.clear();
          var ref = fb.ref("sessions/${k.key}");
          ref.onValue.listen((event) {
            var snp = event.snapshot.children;
            for(var v in snp)
              {
                Session s = Session();
                s.timeStamp = v.key.toString();
                s.date = k.key.toString();
                sessions.add(s);
              }
            totalsessions.value = sessions.length;
          }
          );
        }
    });
  }

  void updateSessions()
  {
    sessions.toSet().toList();
  }
}