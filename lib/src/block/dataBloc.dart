import 'dart:async';
import 'package:flutter/material.dart';
import '../models/datamodel.dart';

class DataBloc {
  final getData = StreamTransformer<DataModel,DataModel>.fromHandlers(
    handleData: (payload,sink){
      sink.add(payload);
    }
  );
}