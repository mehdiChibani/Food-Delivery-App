import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app/bloc/provider.dart';
import 'package:flutter_app/model/fooditem.dart';
import 'package:rxdart/rxdart.dart';

class CardListBloc extends BlocBase {

  CardListBloc();

//Stream that receives a number and changes the count;
  var _listController = BehaviorSubject<List<FoodItem>>.seeded([]);
  CartProvider provider=CartProvider();
  //output
  Stream<List<FoodItem>> get listStream => _listController.stream;
//input
  Sink<List<FoodItem>> get listSink => _listController.sink;
  // business logic
  addTolist(FoodItem foodItem){
    listSink.add(provider.addTolist(foodItem));
  }

  remove(FoodItem foodItem){
    listSink.add(provider.removeTolist(foodItem));
  }
//dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }

}
