import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gmail_responsive/src/bloc/self_profile_bloc/self_profile_bloc.dart';
import 'package:flutter_gmail_responsive/src/config/responsive.dart';
import 'package:flutter_gmail_responsive/src/imports_files/import_screens.dart';
import 'package:flutter_gmail_responsive/src/models/mail_model.dart';

class Mails extends StatefulWidget {
  @override
  _MailsState createState() => _MailsState();
}

class _MailsState extends State<Mails> {
  ScrollController _scrollController =  ScrollController();
  static final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool show = true;


  @override
  void initState() {
    super.initState();
    handleScroll();
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    super.dispose();
  }

  void showFloationButton() {
    setState(() {
      show = true;
    });
  }

  void hideFloationButton() {
    setState(() {
      show = false;
    });
  }

  void handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        hideFloationButton();
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloationButton();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget _buildBody(){
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(15,0,15,5) ,
              sliver: SliverAppBar(
                toolbarHeight: 55,
                primary: false,
                backgroundColor: Colors.white,
                iconTheme: const  IconThemeData(color: Colors.black),
                title: TextBox(),
                pinned: !Responsive.isMobile(context),
                elevation: 2,
                floating: true,
                shape: const  ContinuousRectangleBorder(
                  side :  BorderSide(width: 1,color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(22),
                      bottomRight: Radius.circular(22),
                      topRight:Radius.circular(22),
                      topLeft:Radius.circular(22)),

                ),
                actions: <Widget>[
                  Container(
                    width: 65,
                    child: PopupMenuButton<String>(
                      icon: const CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/200/300?random=1')),

                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: '1',
                            child: Text('1'),
                          ),
                          PopupMenuItem<String>(
                            value: '2',
                            child: Text('2'),
                          ),
                        ];
                      },
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
                      child: Text('INBOX',
                          style:
                          TextStyle(color: Colors.grey[800], fontSize: 12.5)),
                    );
                  }
                  return Dismissible(
                      background: Container(
                          padding: EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          color: Colors.green[900],
                          child: Icon(
                            Icons.archive_outlined,
                            color: Colors.white,
                            size: 30,
                          )),
                      secondaryBackground: Container(
                          padding: EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.green[900],
                          child: Icon(Icons.archive_outlined,
                              color: Colors.white, size: 30)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: () async {
                                  await SelfProfileBloc().getUserProfileApi();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 3.0, bottom: 3.0, right: 0.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                        mailList[index - 1].sender?.imageUrl,
                                        child: Text(
                                          mailList[index - 1].sender?.name[0]??'',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        radius: 24.0,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => ReadMail(
                                                    index: index,
                                                    user: mailList[index - 1].sender,
                                                    image: mailList[index - 1]
                                                        .sender
                                                        ?.imageUrl??Colors.blue,
                                                    time: mailList[index - 1].time,
                                                    text: mailList[index - 1].text,
                                                    subject: mailList[index - 1].subject,
                                                    isstarred:
                                                    mailList[index - 1].isStarred,
                                                  ))),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              mailList[index - 1].unread
                                                  ? Text(
                                                mailList[index - 1].sender?.name??'',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              )
                                                  : Text(
                                                mailList[index - 1].sender?.name??'',
                                                style: TextStyle(fontSize: 18.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width *
                                                    0.6,
                                                child: mailList[index - 1].unread
                                                    ? Text(
                                                  mailList[index - 1].subject,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                                    : Text(
                                                  mailList[index - 1].subject,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width *
                                                    0.6,
                                                child: Text(
                                                  mailList[index - 1].text,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(mailList[index - 1].time),
                                SizedBox(
                                  height: 7.0,
                                ),
                                IconButton(
                                  constraints: BoxConstraints(),
                                  icon: mailList[index - 1].isStarred
                                      ? Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                      : Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.grey,
                                  ),
                                  iconSize: 25.0,
                                  tooltip: 'Star message',
                                  onPressed: () => {
                                    setState(() => {
                                      mailList[index - 1].isStarred =
                                      !mailList[index - 1].isStarred,
                                    }),
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (DismissDirection direction) {
                        setState(() {
                          // Mail deletedItem = mailList.removeAt(index - 1);
                          // _key.currentState
                          //   ..removeCurrentSnackBar()
                          //   ..showSnackBar(
                          //     SnackBar(
                          //       content: Text("1 Archieved",style: TextStyle(color: Colors.white),),
                          //       action: SnackBarAction(
                          //           label: "UNDO",
                          //           onPressed: () => setState(() => mailList.insert(index-1, deletedItem),) // this is what you needed
                          //       ),
                          //     ),
                          //   );

                        });
                      }

                  );
                },
                childCount: mailList.length + 1,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildFloatingButton(){
      return show == true
          ? FloatingActionButton.extended(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (builder) => Compose()));
        },
        label: Text('Compose'),
        icon: Icon(Icons.edit),
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        tooltip: 'Upload',
      )
          : FloatingActionButton(
        child: Icon(
          Icons.edit,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (builder) => Compose()));
        },
      );
    }

    return (!Responsive.isDesktop(context) && !Responsive.isTablet(context)) ?
      Scaffold(
     drawer:  Drawers(),
      key: _key,
      body: _buildBody(),
      floatingActionButton: _buildFloatingButton()
    ):Scaffold(
        body: _buildBody(),
        floatingActionButton: _buildFloatingButton()
       );
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }
}

class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        cursorHeight: 20,
        decoration: InputDecoration(
          hintText: 'Search in mail',
          border: InputBorder.none,
        ),
        onTap: () {
          showSearch(context: context, delegate: Datasearch());
        },
      ),
    );
  }
}

class Datasearch extends SearchDelegate<String> {
  final names = [
    'deepa',
    'deepak',
    'sugarcosmetics',
    'balram',
    'linkedln',
    'banglore',
    'balram0698@gmail.com',
    'pandey.deepa@tcs.com',
    'sugarcosmetics@gmail.com',
    'pandeydeepak821@gmail.com',
    'balram.rathore@tcs.com',
  ];
  final recentSearches = [
    'pandey.deepa@tcs.com',
    'sugarcosmetics@gmail.com',
    'pandeydeepak821@gmail.com',
    'balram0698@gmail.com'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [

      IconButton(
        icon: Icon(Icons.mic),
        onPressed: () {},
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearches
        : names.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.person_search),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(color: Colors.grey))
                ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
