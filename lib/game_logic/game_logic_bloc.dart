import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:soko_number/game_logic/game_algorithms.dart';
import '../constant.dart';
import 'game_object.dart';
import 'game_utility_functions.dart';
part 'game_logic_event.dart';
part 'game_logic_state.dart';


class GameLogicBloc extends Bloc<GameLogicEvent, GameLogicState> {


  GameLogicBloc() : super(
      GameLogicState(twoDList: firstLevel,numberOfMoves: 0)
  ){
    on<CheckIfGameEndEvent>((event, emit) {
      if(checkIfGameIsEnd(stateList: state.twoDList)){
        emit(GameLogicDoneState());
      }
    });

    on<MoveUpPressed>((event, emit) {
      final up2DList = moveUpList(transform2dList:state.twoDList);
      if(up2DList.isNotEmpty){
        print('up');
        emit(GameLogicState(twoDList: up2DList, numberOfMoves: state.numberOfMoves++));

        add(CheckIfGameEndEvent());
      }
    });

    on<MoveLeftPressed>((event, emit) {
      final left2DList = moveLeftList(transform2dList:state.twoDList);
      if(left2DList.isNotEmpty){
        print('up');
      emit(GameLogicState(twoDList: left2DList, numberOfMoves: state.numberOfMoves++));

      add(CheckIfGameEndEvent());
      }
    });

    on<MoveDownPressed>((event, emit) {
      final down2DList = moveDownList(transform2dList:state.twoDList);

      if(down2DList.isNotEmpty){
        print('up');
      emit(GameLogicState(twoDList: down2DList, numberOfMoves: state.numberOfMoves++));

      add(CheckIfGameEndEvent());
      }
    });

    on<MoveRightPressed>((event, emit) {
      final right2DList = moveRightList(transform2dList:state.twoDList);
      if(right2DList.isNotEmpty){
        print('up');
        emit(GameLogicState(twoDList: right2DList, numberOfMoves: state.numberOfMoves++));

        add(CheckIfGameEndEvent());
      }
    });

    on<StartAlgorithmEvent>((event, emit) async {

      GameAlgorithms gameAlgorithms = GameAlgorithms();

       await gameAlgorithms.depthFirstSearch(state.twoDList,emit);
       add(CheckIfGameEndEvent());
    });
  }

}
