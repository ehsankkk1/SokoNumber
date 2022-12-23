import 'package:flutter/material.dart';
import 'game_logic/game_object.dart';

const kGameDimension = 3;

List<List<GameObject>> firstLevel = [
  [EmptyObject(xPosition: 0,yPosition: 0,containedNumberValue: 1),EmptyObject(xPosition: 0,yPosition: 1,finalPlaceNumber: 2),EmptyObject(xPosition: 0,yPosition: 2),],
  [WallObject(xPosition: 1,yPosition: 0),EmptyObject(xPosition: 1,yPosition: 1),WallObject(xPosition: 1,yPosition: 2),],
  [EmptyObject(xPosition: 2,yPosition: 0),EmptyObject(xPosition: 2,yPosition: 1,finalPlaceNumber: 1,containedNumberValue: 2),EmptyObject(xPosition: 2,yPosition: 2),],
];
List<List<GameObject>> secondLevel = [
  [WallObject(xPosition: 0,yPosition: 0,),WallObject(xPosition: 0,yPosition: 1),WallObject(xPosition: 0,yPosition: 2),WallObject(xPosition: 0,yPosition: 3),WallObject(xPosition: 0,yPosition: 4)],
  [EmptyObject(xPosition: 1,yPosition: 0,containedNumberValue: 1),WallObject(xPosition: 1,yPosition: 1),EmptyObject(xPosition: 1,yPosition: 2,containedNumberValue: 2),WallObject(xPosition: 1,yPosition: 3),EmptyObject(xPosition: 1,yPosition: 4,containedNumberValue: 3)],
  [EmptyObject(xPosition: 2,yPosition: 0,finalPlaceNumber: 3),EmptyObject(xPosition: 2,yPosition: 1),EmptyObject(xPosition: 2,yPosition: 2,finalPlaceNumber: 2),EmptyObject(xPosition: 2,yPosition: 3),EmptyObject(xPosition: 2,yPosition: 4,finalPlaceNumber: 1)],
  [WallObject(xPosition: 3,yPosition: 0),WallObject(xPosition: 3,yPosition: 1),EmptyObject(xPosition: 3,yPosition: 2),WallObject(xPosition: 3,yPosition: 3),WallObject(xPosition: 3,yPosition: 4)],
  [WallObject(xPosition: 4,yPosition: 0),WallObject(xPosition: 4,yPosition: 1),WallObject(xPosition: 4,yPosition: 2),WallObject(xPosition: 4,yPosition: 3),WallObject(xPosition: 4,yPosition: 4)],
];
List<List<GameObject>> thirdLevel = [
  [EmptyObject(xPosition: 0,yPosition: 0,containedNumberValue: 1),WallObject(xPosition: 0,yPosition: 1),WallObject(xPosition: 0,yPosition: 2),WallObject(xPosition: 0,yPosition: 3),WallObject(xPosition: 0,yPosition: 4)],
  [EmptyObject(xPosition: 1,yPosition: 0,finalPlaceNumber: 1),EmptyObject(xPosition: 1,yPosition: 1,containedNumberValue: 2),WallObject(xPosition: 1,yPosition: 2),EmptyObject(xPosition: 1,yPosition: 3),WallObject(xPosition: 1,yPosition: 4,)],
  [EmptyObject(xPosition: 2,yPosition: 0),EmptyObject(xPosition: 2,yPosition: 1,finalPlaceNumber: 2),EmptyObject(xPosition: 2,yPosition: 2,containedNumberValue: 3),EmptyObject(xPosition: 2,yPosition: 3,finalPlaceNumber: 4),WallObject(xPosition: 2,yPosition: 4,)],
  [EmptyObject(xPosition: 3,yPosition: 0),EmptyObject(xPosition: 3,yPosition: 1),EmptyObject(xPosition: 3,yPosition: 2,finalPlaceNumber: 3),EmptyObject(xPosition: 3,yPosition: 3,containedNumberValue: 4),WallObject(xPosition: 3,yPosition: 4)],
  [WallObject(xPosition: 4,yPosition: 0),WallObject(xPosition: 4,yPosition: 1),WallObject(xPosition: 4,yPosition: 2),WallObject(xPosition: 4,yPosition: 3),WallObject(xPosition: 4,yPosition: 4)],
];
const kPurple = Color(0xffcf6679);
const kButtons = Color(0xffbd86fc);