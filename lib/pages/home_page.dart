import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.black
                ),
                child: Text("Find pet-friendly\nplaces and parks", style: TextStyle(fontSize: 36, fontFamily: 'JosefinSans-Bold', color: Colors.white),),
              )
          ),
          Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                margin: EdgeInsets.only(left: 16,right: 16,top: 32, bottom: 32),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Around your furry friend", style: TextStyle(fontSize: 22, fontFamily: 'JosefinSans-Bold', color: Colors.black)),
                      Flexible(
                          flex: 4,
                          child: Column(
                            children: [
                              Expanded(child:
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange
                                ),
                              ))
                            ],
                          )
                      ),
                      SizedBox(height: 20,),
                      Text("Explore by", style: TextStyle(fontSize: 22, fontFamily: 'JosefinSans-Bold', color: Colors.black)),
                      SizedBox(height: 10,),
                      Flexible(
                          flex: 2,
                          child: Column(
                            children: [
                              Expanded(child:
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange
                                ),
                              ))
                            ],
                          )
                      ),

                    ],
                  ),
              ),
          )
        ],
      ),
    );
  }
}
