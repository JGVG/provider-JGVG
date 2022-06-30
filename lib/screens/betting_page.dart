import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_provider/models/team.dart';
import 'package:flutter_provider/models/team_provider.dart';

import 'list_page.dart';

class BettingPage extends StatefulWidget {
  final String title;
  BettingPage({Key key, this.title}) : super(key: key);

  @override
  _BettingPageState createState() => _BettingPageState();
}

class _BettingPageState extends State<BettingPage> {
  List<TeamModel> items = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Consumer<TeamProvider>(
              builder: (context, teamProvider, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Center(
                              child: Text(teamProvider.selected_items[0].name, style: TextStyle(fontSize: 40),),
                            ),
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.only(top:20.0, bottom: 20.0),
                            width: 350,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.remove,
                                  size: 35.0,
                                ),
                                onTap: (){
                                  teamProvider.decrement(true);
                                },
                              ),
                              Container(
                                child: Center(
                                  child: Text(teamProvider.result_t1.toString(), style: TextStyle(fontSize: 40)),
                                ),
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add,
                                  size: 35.0,
                                ),
                                onTap: (){
                                  teamProvider.increment(true);
                                },
                              ),
                            ],
                          ),
                          Text("VS", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: Icon(
                                  Icons.remove,
                                  size: 35.0,
                                ),
                                onTap: (){
                                  teamProvider.decrement(false);
                                },
                              ),
                              Container(
                                child: Center(
                                  child: Text(teamProvider.result_t2.toString(), style: TextStyle(fontSize: 40)),
                                ),
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  Icons.add,
                                  size: 35.0,
                                ),
                                onTap: (){
                                  teamProvider.increment(false);
                                },
                              ),
                            ],
                          ),
                          Container(
                            child: Center(
                              child: Text(teamProvider.selected_items[1].name, style: TextStyle(fontSize: 40),),
                            ),
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.only(top:20.0, bottom: 20.0),
                            width: 350,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          teamProvider.buildBet();
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => ListPage(title: 'Pronostica')));
                        },
                        color: Colors.blue[200],
                        child: Container(
                          child: Center(
                            child: Text('pronostico', style: TextStyle(fontSize: 30, color: Colors.white),),
                          ),
                          margin: EdgeInsets.only(top:20.0, bottom: 20.0),
                          width: 350,
                        ),
                      )
                    ],
                )
                );
              }
          ),
        ),
      ),
    );
  }
}