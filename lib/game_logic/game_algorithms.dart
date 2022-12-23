import 'dart:collection';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack/stack.dart';

import 'game_logic_bloc.dart';
import 'game_object.dart';
import 'game_utility_functions.dart';

class GameAlgorithms{

  Future<void> depthFirstSearch(List<List<GameObject>> twoDList,Emitter emit) async {
    List<StateNode> visited = [];
    int visitedNodeCount=0;
    Stack<StateNode> stack = Stack();
    stack.push(StateNode(preState: null, curStates: twoDList));

    while(stack.length > 0){
      StateNode temp = stack.pop();
      visitedNodeCount++;

      if(!checkIfGameIsEnd(stateList: temp.curStates)){
        if(!visited.contains(temp)){
          visited.add(temp);
          for(var element in getNextSatesList(temp)){

            if(!visited.contains(element)){
              stack.push(element);
            }
          }
        }
      }

      else{
        List<List<List<GameObject>>> winningMoves = [];
        StateNode winState = temp;

        while(winState.preState != null){
          winningMoves.add(winState.curStates);
          winState = winState.preState!;
        }
        print("Depth:  ${winningMoves.length}");
        print("visitedNodeCount:  $visitedNodeCount");
        int i=0;
        for(var element in winningMoves.reversed){

          await Future.delayed(const Duration(seconds: 1)).then((value) => emit.isDone);
     
          emit(GameLogicState(twoDList: element, numberOfMoves: i++));

        }

        //add(CheckIfGameEnd());
        
        print('Game Done');
        break;
      }
    }

  }

  Future<void> breadthFirstSearch(List<List<GameObject>> twoDList,Emitter emit) async {
    List<StateNode> visited = [];
    int visitedNodeCount=0;
    Queue<StateNode> queue = Queue();
    queue.add(StateNode(preState: null, curStates: twoDList));

    while(queue.isNotEmpty){
      StateNode temp = queue.first;
      queue.removeFirst();
      visitedNodeCount++;
      if(!checkIfGameIsEnd(stateList: temp.curStates)){

        if(!visited.contains(temp)){
          visited.add(temp);
          for(var element in getNextSatesList(temp)){

            if(!visited.contains(element)){
              queue.add(element);
            }
          }
        }
      }
      else{
        List<List<List<GameObject>>> winningMoves = [];
        StateNode winState = temp;
        while(winState.preState != null){
          winningMoves.add(winState.curStates);
          winState = winState.preState!;
        }
        print("Depth:  ${winningMoves.length}");
        print("visitedNodeCount:  $visitedNodeCount");
        int i=0;
        for(var element in winningMoves.reversed){

          await Future.delayed(const Duration(seconds: 1)).then((value) => emit.isDone);
          emit(GameLogicState(twoDList: element, numberOfMoves: i++));

        }
        print('Game Done');
        break;
      }
    }

  }

  Future<void> dijkstra(List<List<GameObject>> twoDList,Emitter emit) async {
    List<StateNode> visitedDijkstra = [];
    int visitedNodeCount=0;
    List<MapEntry<StateNode,int>> distance = [];
    Queue<MapEntry<StateNode,int>> queue = Queue();

    queue.add(MapEntry(StateNode(preState: null, curStates: twoDList), 1));
    distance.add(MapEntry(StateNode(preState: null, curStates: twoDList), 1));

    while(queue.isNotEmpty){

      visitedNodeCount++;

      MapEntry<StateNode,int> temp = queue.first;
      queue.removeFirst();

      if(!checkIfGameIsEnd(stateList: temp.key.curStates)){

        if(!visitedDijkstra.contains(temp.key)){

          visitedDijkstra.add(temp.key);

          for(var element in getNextSatesListWithWeight(temp.key)){

            if(!visitedDijkstra.contains(element.key)){
              int newDistance = distance.first.value + element.value;
              if(newDistance < distance.first.value){
                distance.firstWhere((element2) => element2.key == element.key).value == newDistance;
              }
              queue.add(element);
            }
          }
        }
      }
      else{
        print('end');
        List<List<List<GameObject>>> winningMoves = [];
        StateNode winState = temp.key;
        while(winState.preState != null){
          winningMoves.add(winState.curStates);
          winState = winState.preState!;
        }
        print("Depth:  ${winningMoves.length}");
        print("visitedNodeCount:  $visitedNodeCount");
        int i=0;
        for(var element in winningMoves.reversed){

          await Future.delayed(const Duration(seconds: 1)).then((value) => emit.isDone);
          emit(GameLogicState(twoDList: element, numberOfMoves: i++));

        }
        print('Game Done');
        break;
      }
    }

  }

  Future<void> aStar(List<List<GameObject>> twoDList,Emitter emit) async {

    int visitedNodeCount=0;
    List<StarNode> open = [];
    List<StarNode> closed = [];

    open.add(
        StarNode(
            stateNode:StateNode(preState: null, curStates: twoDList),
            starValues: StarValues(hCost: getHCost(stateList: twoDList),gCost: 0)
        )
    );

    while(open.isNotEmpty){

      visitedNodeCount++;
      //print(visitedNodeCount);
      StarNode temp(){
        StarNode min = StarNode(
            stateNode: StateNode(preState: null, curStates: twoDList),
            starValues: StarValues(hCost: 1000000000000000)
        );
        for (var element in open) {
          if(element.starValues.fCost() < min.starValues.fCost()){
            min = element;
        }
      }
        return min;
      }

      open.removeWhere((element) => temp().stateNode == element.stateNode);

        if(!checkIfGameIsEnd(stateList: temp().stateNode.curStates)){

          if(!closed.any((element) => temp().stateNode == element.stateNode)){

            closed.add(temp());

            for(var child in getNextSatesListWithStar(temp())){

              if(closed.any((element) => child.stateNode == element.stateNode)){
                continue;
              }
                for(var openNode in open){
                  if(child.starValues.gCost > openNode.starValues.gCost || !open.any((element) => child.stateNode == element.stateNode)){
                    continue;
                  }
                }

                if(!open.any((element) => child.stateNode == element.stateNode)){
                  open.add(child);
                }

            }
          }
        }


        else{
          print('end');
          List<List<List<GameObject>>> winningMoves = [];
          StateNode winState = temp().stateNode;
          while(winState.preState != null){
            winningMoves.add(winState.curStates);
            winState = winState.preState!;
          }
          print("Depth:  ${winningMoves.length}");
          print("visitedNodeCount:  $visitedNodeCount");
          int i=0;
          for(var element in winningMoves.reversed){

            await Future.delayed(const Duration(seconds: 1)).then((value) => emit.isDone);
            emit(GameLogicState(twoDList: element, numberOfMoves: i++));

          }
          print('Game Done');
          break;
        }
      }
    }

  }
  
