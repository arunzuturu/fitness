
import 'package:fitness/View_Model/rehab_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants.dart';

class Rehab extends StatefulWidget {
  const Rehab({Key? key}) : super(key: key);

  @override
  State<Rehab> createState() => _RehabState();
}

class _RehabState extends State<Rehab> {
  final rehab = Get.put(RehabController());
  // final rehab = Get.find<ProgressController>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: size.height*0.08,
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Text("Rehab Programme", style: h1,)),),
              topCard(size),
              SizedBox(
                width: size.width*0.87,
                height: size.height*0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("History", style: h2),
                    const Icon(Icons.filter_alt_sharp, size: 30,)
                  ],
                ),
              ),
              Obx(()=> sessionsCard(size, rehab.totalsessions.value)),
              SizedBox(
                height: size.height*0.3,
                child: Obx(()=> ListView.builder(
                    itemCount: rehab.totalsessions.value,
                    itemBuilder: (context, index){
                      return Obx(()=> listCard(size,
                          rehab.sessions[index].date.toString(),
                          rehab.sessions[index].timeStamp.toString(),
                      ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

Widget listCard(size, time,date)
{
  return SizedBox(
    width: size.width*0.84,
    height: size.height*0.1,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:[
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/images/2.jpg'),
        ),
        SizedBox(width: size.width*0.06),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: Icon(CupertinoIcons.clock, color: Color(0xff6F6F6F),size: 20,),
            ),
            SizedBox(height: 3.40),
            SizedBox(
              width: 20,
              height: 20,
              child: Icon(CupertinoIcons.calendar, color: Color(0xff6F6F6F),size: 20,),
            ),
          ],
        ),
        SizedBox(width: 3.40),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$time",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 3.40),
            Text(
              "$date",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(width: size.width*0.14),
        Text(
          "View Results",
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Widget topCard(size)
{
  return Container(
    width: size.width*0.9,
    height: size.height*0.25,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(9),
      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xff2C92D7),Color(0xff3A7ED9), Color(0xff259CD6)], ),
    ),
    child: Stack(
      children:[
        Positioned(
          left: 100,
          top: 100,
          child: Container(
            width: size.width*0.2,
            height: size.height*0.08,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff79abe1).withOpacity(0.5),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              width: size.width*0.2,
              height: size.height*0.08,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff79abe1).withOpacity(0.5),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: size.width*0.4,
              height: size.height*0.13,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff609ddf).withOpacity(0.5),
              ),
            ),
          ),
        ),
        const Positioned(
          left: 23,
          top: 70,
          child: Text(
            "Mon,Thu,Sat\n3 Sessions/day",
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
        const Positioned(
          left: 23,
          top: 10,
          child: SizedBox(
            width: 161,
            height: 64,
            child: Text(
              "Knee Rehab\nProgramme",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned(
          left: 23,
          top: 112,
          child: Container(
            width: size.width*0.32,
            height: size.height*0.04,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                SizedBox(
                  width: size.width*0.27,
                  height: size.height*0.04,
                  child: const Center(
                    child: Text(
                      "Left Shoulder",
                      style: TextStyle(
                        color: Color(0xff3a7ed9),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          left: 29,
          top: 151,
          child: SizedBox(
            width: 147,
            height: 50,
            child: Text(
              "Assigned By\nJane Doe",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 150,
              height: 150,
              child: Image.asset('assets/images/rehab.png'),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget sessionsCard(size, total)
{
  return SizedBox(
    width: size.width*0.87,
    height: size.height*0.088,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Color(0xffeaeaea),
      ),
      child: Column(
        children: [
          SizedBox(
            width: size.width*0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Total Sessions", style: sub1,),
                  SizedBox(width: size.width*0.1,),
                  Text("Total Time", style: sub1,)
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width*0.8,
            height: size.height*0.034,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/Dumbbell.png'),
                      ),
                      Text("$total", style: h1.copyWith(fontSize: 20,fontWeight: FontWeight.normal))
                    ],
                  ),
                  const VerticalDivider(
                    color: Color(0xff6F6F6F),
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset('assets/images/Hourglass.png'),
                      ),
                      Text("$total", style: h1.copyWith(fontSize: 20, fontWeight: FontWeight.normal),)
                    ],
                  )
                ],
              ),
            ),
          )
        ],

      ),
    ),
  );
}