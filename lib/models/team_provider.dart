import 'package:flutter/material.dart';
import 'package:flutter_provider/models/team.dart';
import 'bet.dart';

class TeamProvider extends ChangeNotifier {
  final List<TeamModel> items = [new TeamModel("Eibar", false), new TeamModel("Sevilla", false), new TeamModel("Elche", false), new TeamModel("Cadiz", false), new TeamModel("Alavés", false), new TeamModel("Athletic", false), new TeamModel("Barcelona", false), new TeamModel("Atlético", false), new TeamModel("Getafe", false), new TeamModel("Granada", false), new TeamModel("Betis", false), new TeamModel("Levante", false), new TeamModel("Osasuna", false), new TeamModel("Levante", false), new TeamModel("R. Sociedad", false), new TeamModel("Real Madrid", false), new TeamModel("Real Valladolid", false), new TeamModel("Valencia", false), new TeamModel("Villarreal", false),];
  List<TeamModel> selected_items = [];
  List<BetModel> bet_list = [];
  int count = 0;
  int result_t1 = 0;
  int result_t2 = 0;

  List<TeamModel> getItems(){
    return items;
  }

  void changeState(BuildContext context, TeamModel item){
    if(count <= 2){
      if(item.is_checked == false){
        if(count < 2){
          item.is_checked = true;
          count++;
        }else{
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Solo puedes seleccionar dos equipos."),
              duration: Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
          ));
        }
      }else{
        item.is_checked = false;
        count--;
      }
    }
    notifyListeners();
  }

  void setTeams(List<TeamModel> selected){
    selected_items = selected;
  }

  void increment(bool selection){
    if(selection){
      result_t1++;
    }else{
      result_t2++;
    }
    notifyListeners();
  }

  void decrement(bool selection){
    if(selection){
      if(result_t1 != 0){
        result_t1--;
      }
    }else{
      if(result_t2 != 0){
        result_t2--;
      }
    }
    notifyListeners();
  }

  void resetCounters(){
    result_t1 = 0;
    result_t2 = 0;
  }

  void buildBet() {
    bet_list.add(new BetModel(selected_items[0].name, result_t1, selected_items[1].name, result_t2));
  }

  void deleteBet(int index) {
    bet_list.removeAt(index);
    notifyListeners();
  }

}





