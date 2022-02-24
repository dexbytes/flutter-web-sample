import 'package:flutter/material.dart';


abstract class SelfProfileState {
  SelfProfileState();
}

class SelfProfileInitStat extends SelfProfileState {}

class SelfProfileInProgressState extends SelfProfileState {
  Map? requestData;
  SelfProfileInProgressState({this.requestData});
}

class GetUserProfileDetailsApiState extends SelfProfileState {
  //UserProfileDetailModel userProfileData;
  GetUserProfileDetailsApiState();

  // @override
  // String toString() => 'ProductAdded { todos: $getMainAppStateModel }';
}

class SelfProfileErrorState extends SelfProfileState {
  SelfProfileErrorState(
      {required BuildContext context, String? errorMessage, String? emailId}) {
    ErrorAlert(
        context: context,
        message: errorMessage,
        callBackYes: (mContext) {
          //appNavigator.popBackStack(mContext);
          Navigator.pop(context);
        });
  }
}


class SelfPronounsUpdateDoneState extends SelfProfileState {
  SelfPronounsUpdateDoneState();
  @override
  String toString() => '  }';
}

class SelfProfileUpdateDoneState extends SelfProfileState {
  SelfProfileUpdateDoneState();
  @override
  String toString() => ' }';
}


class ErrorAlert {
  ErrorAlert(
      {Key? key,
        required BuildContext context,
        String alertTitle = "",
        bool isItForInternet = false,
        required message,
        callBackYes}) {
//    alertPopUp(context,success,msg,callback);
    errorDialog(context, isItForInternet, alertTitle, message, callBackYes);
  }


  Future<bool?> errorDialog(BuildContext context1, bool isItForInternet,
      String alertTitle, String? message, callBackYes) {
    return showDialog(
        context: context1,
        barrierDismissible: !isItForInternet,
        builder: (context1) {
          //mContext = context1;
          return AlertDialog(
            title: new Text(alertTitle,
                style: new TextStyle(
                    color: Colors.black, fontSize: 20.0)),
            content: new Text(message ?? ""),
            actions: <Widget>[
              TextButton(
                child: Text("OK", style: new TextStyle(fontSize: 18.0)),
                onPressed: () {
                  if (callBackYes != null) {
                    callBackYes(context1);
                  } else {
                    Navigator.pop(context1);
                  }
                },
              )
            ],
          );
        });
  }
}