part of 'game_logic_bloc.dart';

abstract class GameLogicEvent extends Equatable {
  const GameLogicEvent();
}

class CheckIfGameEndEvent extends GameLogicEvent{


  @override
  List<Object?> get props => [];
}
class MoveUpPressed extends GameLogicEvent{


  @override
  List<Object?> get props => [];
}
class MoveLeftPressed extends GameLogicEvent{

  @override
  List<Object?> get props => [];
}
class MoveDownPressed extends GameLogicEvent{

  @override
  List<Object?> get props => [];
}
class MoveRightPressed extends GameLogicEvent{

  @override
  List<Object?> get props => [];
}
class StartAlgorithmEvent extends GameLogicEvent{

  @override
  List<Object?> get props => [];
}
