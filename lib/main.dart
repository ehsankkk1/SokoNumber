import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soko_number/game_logic/game_object.dart';
import 'package:soko_number/utility/bloc_observer.dart';
import 'constant.dart';
import 'game_logic/game_logic_bloc.dart';


void main() {
 // Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: BlocProvider(
        create: (context) => GameLogicBloc()..add(StartAlgorithmEvent()),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff121212),

        floatingActionButton: BlocBuilder<GameLogicBloc, GameLogicState>(
          builder: (context, state) {
            if(state is GameLogicDoneState){
              return Container();
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<GameLogicBloc>().add(MoveLeftPressed());
                  },
                  child: const Icon(Icons.arrow_back),
                  backgroundColor: kButtons,
                ),
                const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        context.read<GameLogicBloc>().add(MoveUpPressed());
                      },
                      backgroundColor: kButtons,
                      child: const Icon(Icons.arrow_upward),
                    ),
                    const SizedBox(height: 10,),
                    FloatingActionButton(
                      onPressed: () {
                        context.read<GameLogicBloc>().add(MoveDownPressed());
                      },
                      backgroundColor: kButtons,
                      child: const Icon(Icons.arrow_downward_rounded),
                    ),
                  ],
                ),
                const SizedBox(width: 10,),
                FloatingActionButton(
                  onPressed: () {
                    context.read<GameLogicBloc>().add(MoveRightPressed());
                  },
                  backgroundColor: kButtons,
                  child: const Icon(Icons.arrow_forward),
                ),
              ],
            );
          },
        ),
        body: BlocBuilder<GameLogicBloc, GameLogicState>(
          builder: (context, state) {
            if (state is GameLogicDoneState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Center(child: Text('You win Congrats',
                    style: TextStyle(fontSize: 50, color: Colors.white),)),
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                    state.twoDList.length, (i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        state.twoDList[i].length, (j) {
                      final tempObject = state.twoDList[i][j];
                      if (tempObject is EmptyObject) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          width: 100,
                          height: 100,
                          child: Center(child:
                          Builder(
                              builder: (context) {
                                if (tempObject.containedNumberValue != null) {
                                  return Text(
                                    '${tempObject.containedNumberValue}',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87
                                    ),);
                                }
                                if (tempObject.finalPlaceNumber != null) {
                                  return Text(
                                    '${tempObject.finalPlaceNumber ?? ''}',
                                    style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff03dac6)
                                    ),
                                  );
                                }
                                return Container();
                              }
                          )
                          ),
                        );
                      }
                      return Container(
                        decoration: BoxDecoration(
                            color: kPurple,
                            border: Border.all(
                                color: Colors.black
                            )
                        ),
                        width: 100,
                        height: 100,
                      );
                    }
                    ),
                  );
                }
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



