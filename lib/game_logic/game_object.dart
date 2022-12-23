import 'package:equatable/equatable.dart';


abstract class GameObject extends Equatable{
   int xPosition;
   int yPosition;
   GameObject({required this.xPosition,required this.yPosition});

}

class WallObject extends GameObject{

   WallObject({required super.xPosition,required super.yPosition});

   WallObject copyWith({
      int? xPosition,
      int? yPosition,

   }) {
      return WallObject(
         xPosition: xPosition ?? this.xPosition,
         yPosition: yPosition ?? this.yPosition,

      );
   }

  @override
  List<Object?> get props => [xPosition,yPosition];
}


class EmptyObject extends GameObject{

   int? finalPlaceNumber;
   int? containedNumberValue;
   EmptyObject({required super.xPosition,required super.yPosition,this.finalPlaceNumber,this.containedNumberValue});

   EmptyObject copyWith({
      int? xPosition,
      int? yPosition,
      int? finalPlaceNumber,
      int? containedNumberValue,

   }) {
      return EmptyObject(
         xPosition: xPosition ?? this.xPosition,
         yPosition: yPosition ?? this.yPosition,
         finalPlaceNumber: xPosition ?? this.finalPlaceNumber,
         containedNumberValue: yPosition ?? this.containedNumberValue,

      );
   }
   @override
   List<Object?> get props => [xPosition,yPosition,finalPlaceNumber,containedNumberValue];
}

class StateNode extends Equatable{
   StateNode? preState;
   List<List<GameObject>> curStates;

   StateNode({required this.preState,required this.curStates});

  @override
  List<Object?> get props => [curStates];
}

class StarValues extends Equatable{
   StarValues({required this.hCost,this.gCost=1});
   int hCost;
   int gCost = 1;
   int fCost() => hCost+gCost;

  @override
  List<Object?> get props => [hCost,gCost,fCost()];
}
class StarNode extends Equatable{
   StateNode stateNode;
   StarValues starValues;

  StarNode({required this.stateNode, required this.starValues});

   @override
   List<Object?> get props => [starValues,stateNode];
}