import 'package:flutter/material.dart';
import 'package:flutter_provider/models/team.dart';
import 'package:flutter_provider/models/team_provider.dart';
import 'package:provider/provider.dart';
import 'betting_page.dart';
import 'list_page.dart';

class SelectionPage extends StatefulWidget {
  final String title;
  SelectionPage({Key key, this.title}) : super(key: key);

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {

  // Compruebo el estado de los equipos, si estas checkeados o no.
  Icon checkStateIcon(bool state) {
    Icon icon;
    if(state == false){
      icon = Icon(Icons.radio_button_unchecked);
    }else{
      icon = Icon(Icons.check_circle_outline);
    }
    return icon;
  }

  // Solo pasará a la página de apuesta si se ha seleccionado a dos equipos.
  bool ckeckIntoBettingPage(){
    int count = 0;
    List<TeamModel> items = Provider.of<TeamProvider>(context, listen: false).getItems();

    items.forEach((item) {
      if(item.is_checked == true){
        count++;
      }
    });

    if(count == 2){
      return true;
    }else{
      return false;
    }

  }

  // Recoge los equipos seleccionados y se lo agrego al proveedor.
  void getTeamsToSet(){
    List<TeamModel> items = Provider.of<TeamProvider>(context, listen: false).getItems();
    List<TeamModel> selected = [];

    items.forEach((item) {
      if(item.is_checked == true){
        selected.add(item);
      }
    });

    Provider.of<TeamProvider>(context, listen: false).setTeams(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.storage,
            size: 35.0,
          ),
          onTap: (){
            Navigator.push(context,  MaterialPageRoute(builder: (context) => ListPage(title: 'Pronostica')));
          },
        ),
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              child: Icon(
                Icons.monetization_on,
                size: 35.0,
              ),
              onTap: () async {
                if(ckeckIntoBettingPage()){
                  getTeamsToSet();
                  Provider.of<TeamProvider>(context).resetCounters();
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => BettingPage(title: 'Pronostica')));
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Debe seleccionar dos equipos para apostar."),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                  ));
                }
              },
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Consumer<TeamProvider>(
              builder: (context, teamProvider, child) {
                return ListView.separated(
                  itemCount: teamProvider.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(teamProvider.items[index].name),
                      trailing: checkStateIcon(teamProvider.items[index].is_checked),
                      onTap: (){
                        Provider.of<TeamProvider>(context).changeState(context, teamProvider.items[index]);
                      },
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
