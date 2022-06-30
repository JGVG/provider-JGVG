import 'package:flutter/material.dart';
import 'package:flutter_provider/models/team_provider.dart';
import 'package:flutter_provider/screens/selection_page.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  final String title;
  ListPage({Key key, this.title}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.keyboard_backspace),
              onPressed: () => Navigator.push(context,  MaterialPageRoute(builder: (context) => SelectionPage(title: 'Pronostica'))));
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Consumer<TeamProvider>(
              builder: (context, teamProvider, child) {
                return ListView.separated(
                  itemCount: teamProvider.bet_list.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      background: Container(color: Colors.red),
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        teamProvider.deleteBet(index);
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Elemento eliminado")));
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(teamProvider.bet_list[index].nameteam1),
                            Text(teamProvider.bet_list[index].resultTeam1.toString()),
                            Text('-'),
                            Text(teamProvider.bet_list[index].resultTeam2.toString()),
                            Text(teamProvider.bet_list[index].nameteam2),
                          ],
                        ),
                        onTap: (){

                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {return Divider();},
                );
              }
          ),
        ),
      ),
    );
  }
}