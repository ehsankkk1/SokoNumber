
import 'package:bloc/bloc.dart';
import 'package:soko_number/utility/bloc_observer.dart';
import 'game_logic/game_logic_bloc.dart';


Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  print('hello world');
  GameLogicBloc gameLogicBloc = GameLogicBloc();


  //gameLogicBloc.add(CheckIfGameEnd());
  gameLogicBloc.add(MoveUpPressed());

}




