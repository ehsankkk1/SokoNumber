part of 'game_logic_bloc.dart';

class GameLogicState extends Equatable {

  List<List<GameObject>> twoDList = [];
  num numberOfMoves = 0;
  GameLogicState({this.twoDList = const[],this.numberOfMoves = 0});


  GameLogicState copyWith({
    List<List<GameObject>>? twoDList,
    num? numberOfMoves,

  }) {
    return GameLogicState(
      twoDList: twoDList ?? this.twoDList,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,

    );
  }
  @override
  List<Object?> get props => [twoDList,numberOfMoves];

  @override
  bool? get stringify => true;
}
class GameLogicDoneState extends GameLogicState{}
