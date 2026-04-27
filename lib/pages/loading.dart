import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "loading";
  void setupWorldTime() async{
    WorldTime wt = WorldTime(
        location: "Berlin" ,
        flag: "germany.png",
        url: "Europe/Berlin"
    );
    await wt.getData();
    // print(wt.time);
    setState(() {
      time = wt.time ?? "could not get time";
    });
    // sending data to another route
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location' : wt.location,
      'flag': wt.flag,
      'time': wt.time,
      'isDayTime': wt.isDayTime,
    });
  }


  @override
  void initState(){
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.blue[900],
      body: Center(
        child:SpinKitCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
