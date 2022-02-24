import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gmail_responsive/src/imports_files/import_configs.dart';
import 'package:flutter_gmail_responsive/src/imports_files/import_screens.dart';
import 'package:flutter_gmail_responsive/src/imports_files/import_values.dart';
import 'package:flutter_gmail_responsive/src/models/mail_model.dart';

class GmailDashboardPage extends StatefulWidget {
  const GmailDashboardPage({Key? key}) : super(key: key);

  @override
  _GmailDashboardPageState createState() => _GmailDashboardPageState();
}

class _GmailDashboardPageState extends State<GmailDashboardPage> {

    int _currentIndex = 0;
    final List<Widget> _children = [Mails(), Meet()];
    
    void firebaseOnMessaging(){
      FirebaseMessaging.onMessage.listen((message) { 
        if (message != null) {
          final title = message.notification?.title;
          final body = message.notification?.body;
          
          showDialog(context: context, builder: (context){
            return SimpleDialog(
              contentPadding: EdgeInsets.all(8),
              children: [
                Text(title!),
                Text(body!),
              ],
            );
          });
        }
        
        
      });
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseOnMessaging();
  }

    @override
    Widget build(BuildContext context) {
      // It provide us the width and height
      Size _size = MediaQuery.of(context).size;


      void onTabTapped(int index) {
        setState(() {
          _currentIndex = index;
        });
      }

      Widget tabletAndDesktopView = Row(
        children: [
          // Once our width is less then 1300 then it start showing errors
          // Now there is no error if our width is less then 1340
          Expanded(
              flex: 2,
              child: Drawers()),
          Expanded(
            flex:  4,
            child: _children[_currentIndex],
          ),
        ],
      );

      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Responsive(
            // Let's work on our mobile part
            mobile: _children[_currentIndex],
            tablet: tabletAndDesktopView,
            desktop: tabletAndDesktopView,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Colors.black,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0),
                child:  Stack(
                  children: <Widget>[
                    const Icon(
                      Icons.mail,
                      size: 35,
                    ),
                    Positioned(
                      right: 0,
                      top: 0.0,
                      child:  Container(
                        padding: EdgeInsets.all(1),
                        decoration:  BoxDecoration(
                          color: appColors.kBadgeColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: const Text(
                          '9+',
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              label: appStrings.mail,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.video_call, size: 35.0),
              label: appStrings.meet,
            )
          ],
        ),
      );
    }
  }


