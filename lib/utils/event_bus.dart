import 'dart:async';

import 'package:provider/provider.dart';
import 'package:stradda_01/carros/simple.bloc.dart';

class Event{



}
class EventBus  {



  final _streamController = StreamController <Event>.broadcast();

  Stream <Event> get stream => _streamController.stream;

  sendEvent(Event event) {
   _streamController.add(event);
  }

  dipose (){
    _streamController.close();
  }
  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);
}