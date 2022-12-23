import '../constant.dart';
import 'game_object.dart';


List<StateNode> getNextSatesList(StateNode stateNode){
  List<StateNode> nextStates = [];
  final upState = moveUpList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final downState = moveDownList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final rightState = moveRightList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final leftState = moveLeftList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  if(upState.isNotEmpty){
    nextStates.add(StateNode(preState: stateNode,curStates: upState));
  }
  if(downState.isNotEmpty){
    nextStates.add(StateNode(preState: stateNode,curStates: downState));
  }
  if(rightState.isNotEmpty){
    nextStates.add(StateNode(preState: stateNode,curStates: rightState));

  }
  if(leftState.isNotEmpty){
    nextStates.add(StateNode(preState: stateNode,curStates: leftState));

  }
  return nextStates;
}

List<MapEntry<StateNode,int>> getNextSatesListWithWeight(StateNode stateNode){
  List<MapEntry<StateNode,int>> nextStates = [];
  final upState =   moveUpList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final downState = moveDownList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final rightState = moveRightList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  final leftState = moveLeftList(transform2dList: deepCopy2dList(stateList: stateNode.curStates));
  if(upState.isNotEmpty){
    nextStates.add(MapEntry(StateNode(preState: stateNode,curStates: upState), 1));
  }
  if(downState.isNotEmpty){
    nextStates.add(MapEntry(StateNode(preState: stateNode,curStates: downState),1));
  }
  if(rightState.isNotEmpty){
    nextStates.add(MapEntry(StateNode(preState: stateNode,curStates: rightState),1));

  }
  if(leftState.isNotEmpty){
    nextStates.add(MapEntry(StateNode(preState: stateNode,curStates: leftState),1));

  }
  return nextStates;
}


List<StarNode> getNextSatesListWithStar(StarNode starNode){

  List<StarNode> nextStates = [];
  final upState =   moveUpList(transform2dList: deepCopy2dList(stateList: starNode.stateNode.curStates));
  final downState = moveDownList(transform2dList: deepCopy2dList(stateList: starNode.stateNode.curStates));
  final rightState = moveRightList(transform2dList: deepCopy2dList(stateList: starNode.stateNode.curStates));
  final leftState = moveLeftList(transform2dList: deepCopy2dList(stateList: starNode.stateNode.curStates));
  int steps(){
    int t=0;
    StateNode winState = starNode.stateNode;
    while(winState.preState != null){
      t++;
      winState = winState.preState!;
    }
    return t;
  }

  if(upState.isNotEmpty){
    nextStates.add(StarNode(stateNode:StateNode(preState: starNode.stateNode,curStates: upState), starValues:StarValues(hCost: getHCost(stateList: upState),gCost: starNode.starValues.gCost + steps())));
  }
  if(downState.isNotEmpty){
    nextStates.add(StarNode(stateNode:StateNode(preState: starNode.stateNode,curStates: downState),starValues:StarValues(hCost: getHCost(stateList: downState),gCost: starNode.starValues.gCost + steps())));
  }
  if(rightState.isNotEmpty){
    nextStates.add(StarNode(stateNode:StateNode(preState: starNode.stateNode,curStates: rightState),starValues:StarValues(hCost: getHCost(stateList:rightState),gCost: starNode.starValues.gCost + steps())));

  }
  if(leftState.isNotEmpty){
    nextStates.add(StarNode(stateNode:StateNode(preState: starNode.stateNode,curStates: leftState),starValues:StarValues(hCost: getHCost(stateList: leftState),gCost: starNode.starValues.gCost + steps())));

  }
  return nextStates;
}

bool checkIfGameIsEnd({required List<List<GameObject>> stateList}){
  bool temp = false;
  for(int i=0;i< stateList.length;i++){
    for(int j=0;j< stateList[i].length;j++){
      final tempObject = stateList[i][j];
      if(tempObject is EmptyObject){
        if(tempObject.finalPlaceNumber  == tempObject.containedNumberValue){
          temp = true;
        }else{
          return false;
        }
      }
    }
  }
  return temp;
}

int getHCost({required List<List<GameObject>> stateList}){
  int hCost=0;
  for(int i=0;i< stateList.length;i++){
    for(int j=0;j< stateList[i].length;j++){
      final tempObject = stateList[i][j];
      if(tempObject is EmptyObject){
        if(tempObject.finalPlaceNumber  != tempObject.containedNumberValue){
          hCost++;
        }
      }
    }
  }
  return hCost;
}

List<List<GameObject>> deepCopy2dList({required List<List<GameObject>> stateList}){
  List<List<GameObject>> transform2dList = [];
  for(int i=0;i < kGameDimension;i++){
    transform2dList.add([]);
    for(int j =0; j < kGameDimension;j++){
      final temp = stateList[i][j];
      if(transform2dList.isEmpty){
        if(temp is EmptyObject){
          transform2dList[i][0] = temp.copyWith();
        }
        else if(temp is WallObject){
          transform2dList[i][0] = temp.copyWith();
        }
      }
      else{
        if(temp is EmptyObject){
          transform2dList[i].add(temp.copyWith());
        }
        else if(temp is WallObject){
          transform2dList[i].add(temp.copyWith());
        }
      }
    }
  }
  return transform2dList;
}

List<List<GameObject>> moveUpList({required List<List<GameObject>> transform2dList}){

  List<GameObject> validMoves=[];

  for(int i=0;i< kGameDimension;i++){
    for(int j=0;j< kGameDimension;j++){

      final tempObject = transform2dList[i][j];

      if(tempObject is EmptyObject && tempObject.containedNumberValue != null && i > 0){
        final upObject = transform2dList[i-1][j];

        if(upObject is EmptyObject && upObject.containedNumberValue == null){
          validMoves.add(tempObject);
        }
      }
    }
  }
  if(validMoves.isEmpty){
    return [];
  }
  for (var element in validMoves) {
    GameObject upObject = transform2dList[element.xPosition-1][element.yPosition];

    if(upObject is EmptyObject && element is EmptyObject){
      upObject.containedNumberValue = element.containedNumberValue;
      element.containedNumberValue = null;
    }
  }
  return transform2dList;
}

List<List<GameObject>> moveLeftList({required List<List<GameObject>> transform2dList}){

  List<GameObject> validMoves=[];
  for(int i=0;i< kGameDimension;i++){
    for(int j=0;j< kGameDimension;j++){

      final tempObject = transform2dList[i][j];

      if(tempObject is EmptyObject && tempObject.containedNumberValue != null && j > 0){
        final leftObject = transform2dList[i][j-1];

        if(leftObject is EmptyObject && leftObject.containedNumberValue == null){
          validMoves.add(tempObject);
        }
      }
    }
  }
  if(validMoves.isEmpty){
    return [];
  }
  for (var element in validMoves) {
    GameObject leftObject = transform2dList[element.xPosition][element.yPosition-1];

    if(leftObject is EmptyObject && element is EmptyObject){
      leftObject.containedNumberValue = element.containedNumberValue;
      element.containedNumberValue = null;
    }
  }

  return transform2dList;
}

List<List<GameObject>> moveDownList({required List<List<GameObject>> transform2dList}){

  List<GameObject> validMoves = [];
  for(int i=0;i< kGameDimension;i++){
    for(int j=0;j< kGameDimension;j++){

      final tempObject = transform2dList[i][j];

      if(tempObject is EmptyObject && tempObject.containedNumberValue != null && i+1 < kGameDimension){
        final downObject = transform2dList[i+1][j];

        if(downObject is EmptyObject && downObject.containedNumberValue == null){
          validMoves.add(tempObject);
        }
      }
    }
  }
  if(validMoves.isEmpty){
    return [];
  }
  for (var element in validMoves) {
    GameObject downObject = transform2dList[element.xPosition+1][element.yPosition];

    if(downObject is EmptyObject && element is EmptyObject){
      downObject.containedNumberValue = element.containedNumberValue;
      element.containedNumberValue = null;
    }
  }

  return transform2dList;
}

List<List<GameObject>> moveRightList({required List<List<GameObject>> transform2dList}){
  List<GameObject> validMoves = [];
  for(int i=0;i< kGameDimension;i++){
    for(int j=0;j< kGameDimension;j++){

      final tempObject = transform2dList[i][j];

      if(tempObject is EmptyObject && tempObject.containedNumberValue != null && j+1 < kGameDimension){
        final rightObject = transform2dList[i][j+1];

        if(rightObject is EmptyObject && rightObject.containedNumberValue == null){
          validMoves.add(tempObject);
        }
      }
    }
  }
  if(validMoves.isEmpty){
    return [];
  }
  for (var element in validMoves) {
    GameObject rightObject = transform2dList[element.xPosition][element.yPosition+1];

    if(rightObject is EmptyObject && element is EmptyObject){
      rightObject.containedNumberValue = element.containedNumberValue;
      element.containedNumberValue = null;
    }
  }

  return transform2dList;
}



