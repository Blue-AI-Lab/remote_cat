// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
import 'package:remote_cat/SlidingScreen.dart';
import 'package:remote_cat/sendMqttMessage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
// import 'package:flutter/widgets.dart';



class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Create a GlobalKey
  Color _tileColor = Colors.transparent; // Initial color

  void _onTileTap() {
    setState(() {
      // Change the color when tapped
      _tileColor = _tileColor == Colors.transparent ? Colors.blue : Colors.transparent;
    });
    // print("Hello");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      endDrawer: Drawer(
        
        width: 500,
        child: ListView(

          children:[
            const DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.black54,
                image: DecorationImage(
                  image: AssetImage("assets/fxec.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child:Text("Location ",style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),)
                          
            ),
            
            ListTile(
              title: const Text("APJ Block"),
              leading:const Icon(Icons.account_balance),
              // hoverColor: Colors.lightBlue,
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              onTap: _onTileTap
              
              

            ),
            ListTile(
              title: const Text("Main Block"),
              leading:const Icon(Icons.school),

              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              onTap: (){
                
              },



            ),
            ListTile(
              title: Text("Mechanical Block"),
              leading: Icon(Icons.precision_manufacturing),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

            ),
            ListTile(
              title: Text("COE Block"),
              leading: Icon(Icons.assignment_ind),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

            ),
            ListTile(
              title: Text("Library"),
              leading: Icon(Icons.local_library),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),

              
            ),
            ListTile(
              title: Text("Canteen"),
              leading: Icon(Icons.fastfood),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
              onTap: (){
                print("hello");
              },
            ),
            ListTile(
              title: Text("Play Ground"),
              leading: Icon(Icons.directions_run),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            ListTile(
              title: Text("Basket-ball Ground"),
              leading: Icon(Icons.sports_basketball),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            ListTile(
            title: Text("Gym"),
              leading: Icon(Icons.fitness_center),
              contentPadding: const EdgeInsets.fromLTRB(50.0,10.0,0.0,0.0),
            ),
            
            
          ],


        ),
      ),

      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Icon(Icons.wheelchair_pickup_rounded),
        // actions: <Widget> [
        //   Icon(Icons.abc)

        // ],
      ),

      drawer:  Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,              ),
              child: Text(' Header'),
            ),
            ListTile(
              title: const Text('Home'),

              onTap: () {
                // Update the state of the app
                // Then close the drawer
                // Navigator.pop(context);
              },

            ),

            ListTile(
              title: const Text("hello"),

              onTap: () =>{
                // print("hello"),
                Navigator.pop(context)
                
                }

            )
          ],
        ),
      ),



      body: Row(

        children: [
          Expanded(
            flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [
                  Image.asset("assets/chair.png",height: 300,width: 200),
                  Container(
                    child: Row(
                      crossAxisAlignment:CrossAxisAlignment.center ,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Center(
                            child: speedometer(),
                          ),
                      ],

                    
                    ),
                    
                  )
                ],

                

              ),
              
            ),

            Expanded(
              flex: 7,
              child: SlidingScreen()
          )
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.black87,

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
                IconButton(onPressed: ()=>{sendMqttMessage("test.mosquitto.org", "test/topic", "ON")},iconSize: 40, icon: Icon(Icons.mic_rounded,color:Colors.white,weight: 100,),hoverColor: Colors.blue,),
                IconButton(onPressed: ()=>{sendMqttMessage('test.mosquitto.org', 'test/topic', 'Hello MQTT!')},iconSize: 30, icon: Icon(Icons.dangerous,color:Colors.redAccent),hoverColor: Colors.white,),
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 30, icon: Icon(Icons.home,color:Colors.white),hoverColor: Colors.blue,),

                IconButton(onPressed: ()=>{
                      _scaffoldKey.currentState!.openEndDrawer() // Use the GlobalKey to open the drawer
                },
                iconSize: 30, icon: Icon(Icons.location_pin,color:Colors.white),hoverColor: Colors.blue,),
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 30, icon: Icon(Icons.volume_up,color:Colors.white),hoverColor: Colors.blue,),
                
            ],
          ),
        ),

      ),
    );
  }








  SizedBox speedometer() {
    return SizedBox(
                    width: 200,  // Width of the speedometer
                    height: 200,
                                   // Height of the speedometer
                    child: SfRadialGauge(
                    axes: <RadialAxis>[
                    RadialAxis(
                              minimum: 0,
                              maximum: 40,
                              ranges: <GaugeRange>[
                                          GaugeRange(startValue: 0, endValue: 10, color: Colors.green),
                                          GaugeRange(startValue: 10, endValue: 20, color: Colors.yellow),
                                          GaugeRange(startValue: 20, endValue: 30, color: Colors.orange),
                                          GaugeRange(startValue: 30, endValue: 40, color: const Color.fromARGB(255, 247, 16, 0)),

                                        ],
                        pointers: const <GaugePointer>[
                                            NeedlePointer(value: 0),  // Default pointer at 50
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                      widget: Container(
                        child:const Text('50 km/h',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                angle: 90,
                positionFactor: 0.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}