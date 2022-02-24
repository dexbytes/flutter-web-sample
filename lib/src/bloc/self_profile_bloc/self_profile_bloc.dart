import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gmail_responsive/src/bloc/self_profile_bloc/self_profile_event.dart';
import 'package:flutter_gmail_responsive/src/bloc/self_profile_bloc/self_profile_state.dart';


class SelfProfileBloc extends Bloc<SelfProfileEvent, SelfProfileState> {
  SelfProfileBloc() : super(SelfProfileInitStat());

  @override
  Stream<SelfProfileState> mapEventToState(SelfProfileEvent event) async* {
    if (event is GetUserProfileDetailsApiEvent) {
      var response = await getUserProfileApi();
      if (response != null &&
          response.status != null &&
          response.status &&
          response.responseData != null) {
        yield GetUserProfileDetailsApiState();
      }
    }
  }


  //Get type request function with input data
  Future getUserProfileApi({requestData}) async {
    String url = 'https://randomuser.me/api/';
    var response = await http.get(Uri.parse(url));
    if (response != null) {
      if (response.body != null) {
        var responseBody = response.body;
        var responseBody1 = response.body;

      }
    }
  }
}