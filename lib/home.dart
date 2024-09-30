// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';
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
    print("Hello");
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      endDrawer: Drawer(
        
        width: 500,
        child: ListView(

          children:[
            DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.lightBlue,
                image:DecorationImage(
                  image: AssetImage("assets/fxec.jpg"),
                  fit: BoxFit.cover
                )
              ),
              child:Text(" "),
                          
            ),
            ListTile(
              title: const Text("Select locaatiion "),
              leading:const Icon(Icons.account_balance),
              // hoverColor: Colors.lightBlue,
              contentPadding: const EdgeInsets.fromLTRB(10.0,10.0,0.0,30.0),
              
              

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
        backgroundColor: Colors.blue,
        // leading: Icon(Icons.back_hand),
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
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: double.infinity,
                            color: Colors.orange,
                            margin: const EdgeInsets.only(left: 50),
                          )
                          // )
                        ],
                      ),
                    ),
                ],


                )
              ),

            Expanded(
              flex: 7,
              child: Container(
              color: Colors.white,
            


            ))
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        height: 100,
        color: Colors.black87,

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 40, icon: Icon(Icons.mic_rounded,color:Colors.white,weight: 100,),hoverColor: Colors.blue,),
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 30, icon: Icon(Icons.dangerous,color:Colors.redAccent),hoverColor: Colors.white,),
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 30, icon: Icon(Icons.home,color:Colors.white),hoverColor: Colors.blue,),

                IconButton(onPressed: ()=>{
              _scaffoldKey.currentState!.openEndDrawer() // Use the GlobalKey to open the drawer
                },iconSize: 30, icon: Icon(Icons.location_pin,color:Colors.white),hoverColor: Colors.blue,),
                IconButton(onPressed: ()=>{print("button taped")},iconSize: 30, icon: Icon(Icons.volume_up,color:Colors.white),hoverColor: Colors.blue,),




            ],
          ),
        ),

      ),
    );
  }
}