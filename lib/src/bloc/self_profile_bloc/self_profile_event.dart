import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


abstract class SelfProfileEvent extends Equatable {
  final Map? requestData;
  final BuildContext? context;
  const SelfProfileEvent({this.context, this.requestData});
  @override
  List<Object> get props => [];
}



//get user profile details in background
class GetUserProfileDetailsApiEvent extends SelfProfileEvent {
  final BuildContext? context;
  final bool isDisplayLoader;
  GetUserProfileDetailsApiEvent({required this.context,this.isDisplayLoader = true});
  @override
  String toString() => 'RemoveProduct { index: }';
}

