
import 'package:fitness/View_Model/rehab_viewmodel.dart';
import 'package:fitness/View_Model/session_viewmodel.dart';
import 'package:fitness/constants.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final progController = Get.put(ProgressController());
  final storeController = Get.put(RehabController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            progController.addSession();
            progController.getCount();
            storeController.updateSessions();
          },
          child: Container(
            width: size.width * 0.6,
            height: size.height * 0.07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xff5196ff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20.0,
                  ),
                ]),
            child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.play_fill, color: Colors.white,),
                    SizedBox(width: size.width*0.02,),
                    const Text(
              "Start Session",
              style: TextStyle(color: Colors.white),
            ),
                  ],
                )),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 18.0, top: 20),
            child: Container(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning,\nJane",
                    style: h1,
                  ),
                  Obx(() => HeadingCard(
                      size, ((progController.count / 10) * 100).toInt())),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height*0.6,
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Obx(()=> TimeLine(size, progController.bools[index], index,progController.data));
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Widget HeadingCard(size, percentage) {
  return Container(
      width: size.width * 0.90,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xff9c9c9c),
          width: 2.5,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Today's Progress",
                    style: h2,
                  ),
                  Text(
                    "$percentage%",
                    style: h2.copyWith(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: LinearPercentIndicator(
              barRadius: Radius.circular(30),
              width: size.width * 0.82,
              lineHeight: 14.0,
              percent: percentage / 100,
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
                    child: Image.asset(
                      'assets/images/pending.png',
                      scale: 1.2,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "Completed",
                        style: sub1,
                      ),
                      Text(
                        "${(percentage / 10).toInt()} Sessions",
                        style: sub1.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/Done.png',
                      scale: 1.2,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "Pending",
                        style: sub1,
                      ),
                      Text(
                        "${(10 - percentage / 10).toInt()} Sessions",
                        style: sub1.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ));
}

Widget TimeLine(size, status, index, sessions) {
  return Column(
    children: [
      TimelineTile(
        beforeLineStyle: status ? const LineStyle(color: Colors.blue) : const LineStyle(color: Colors.grey),
        afterLineStyle: status ? const LineStyle(color: Colors.blue) : const LineStyle(color: Colors.grey) ,
        alignment: TimelineAlign.start,
        indicatorStyle: IndicatorStyle(
            indicator: Container(
          decoration: BoxDecoration(
            color: status ? Colors.blueAccent : Colors.grey,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: status ? const Icon(
            Icons.done_sharp,
            size: 12,
            color: Colors.white,
          ): null),
        )),
        isFirst: index==0 ? true : false,
        endChild: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SessionCard(size, status, index, sessions)),
      ),
    ],
  );
}

Widget SessionCard(size, status, index, sessions) {
  return Stack(
    children: [
      Container(
          constraints: BoxConstraints(minHeight: size.height * 0.2),
          color: status ? Colors.grey.withOpacity(0.35) : Colors.transparent),
      Container(
          constraints: BoxConstraints(minHeight: size.height * 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xff9c9c9c),
              width: 2.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Session ${index+1}",
                      style:
                          h2.copyWith(fontWeight: FontWeight.w600, fontSize: 21),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: status ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 8, bottom: 8),
                        child: Text(
                          status ? "Completed" : "Start",
                          style: sub1.copyWith(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                    (status) ? Obx(
                      ()=>Text(
                        "Performed at\n ${sessions[index].timeStamp}",
                        style: sub1,
                      ),
                    ) : SizedBox(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Container(
                  width: size.width * 0.35,
                  height: size.height * 0.18,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/3.jpg')),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          )),
    ],
  );
}
