import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/View_Model/session_viewmodel.dart';
import 'package:fitness/constants.dart';
import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';
import 'package:fitness/View_Model/session_viewmodel.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final progController = Get.put(ProgressController());
  final fb = FirebaseDatabase.instanceFor(app: Firebase.app(),databaseURL: "https://fitness-87807-default-rtdb.asia-southeast1.firebasedatabase.app");
  @override

  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: (){
            _addsession();
            progController.getCount();
          },
          child: Container(
            width: size.width*0.6,
            height: size.height*0.07,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xff5196ff),
                boxShadow: [new BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20.0,
                ),]
            ),
            child: Center(child: Text("Start Session", style: TextStyle(color: Colors.white),)),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 18.0,top: 20),
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning,\nJane",style: h1,),
                Obx(()=> HeadingCard(size,(progController.count/10 )*100)),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(child: TimeLine(size)),
                )


              ],
            ),
          ),
        ),
      )
      
    );
  }
  Future<void> _addsession()
  async {
    final now = new DateTime.now();
    String formatter = now.toString().substring(0,10);
    String time = DateFormat.jm().format(now);
    var ref = fb.ref('sessions/$formatter/$time');
    await ref.set("Session 7");
  }
}


Widget HeadingCard(size, percentage)
{
  return Container(
    width: size.width*0.90,
    height: size.height*0.15,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xff9c9c9c), width: 4, ),
    ),
    child: Column(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Today's Progress", style: h2,),
                Text("$percentage%",style: h2.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:10.0),
          child: LinearPercentIndicator(
            width: size.width*0.82,
            lineHeight: 14.0,
            percent: percentage/100,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.airplane_ticket, size: 30,),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text("Completed"),
                    Text("2 Sessions")
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.airplane_ticket, size: 30,),
                ),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text("Pending"),
                    Text("2 Sessions")
                  ],
                )
              ],
            ),
          ],
        )

      ],
    )
  );
}

Widget TimeLine(size)
{
  return Column(
    children: [
      TimelineTile(
        afterLineStyle: LineStyle(color: Colors.blue),
        alignment: TimelineAlign.start,
        isFirst: true,
        endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          color: Colors.lightGreenAccent,
        ),
      ),

      TimelineTile(
        beforeLineStyle: LineStyle(color: Colors.blue),
        alignment: TimelineAlign.start,
        hasIndicator: true,
        endChild: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            color: Colors.lightGreenAccent,

          ),
        ),
      ),
    ],
  );
}