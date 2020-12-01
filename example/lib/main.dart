import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:data_finder/data_finder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await DataFinder.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              RaisedButton(onPressed: () => DataFinder.initDataFinder("204291", showLog: true), child: Text("init")),
              RaisedButton(onPressed: () => DataFinder.setUserUniqueID("sf180"), child: Text("setUserUniqueID")),
              RaisedButton(
                onPressed: () => DataFinder.onEventV3("predefine_pageview", params: {
                  "url_path": "clue/clue_info",
                  "title": "线索详情",
                }),
                child: Text("onEventV3-Page"),
              ),
              RaisedButton(
                onPressed: () => DataFinder.onEventV3("click_button", params: {
                  "name": "article_click",
                  "label": "内容-文章按钮",
                }),
                child: Text("onEventV3-Btn"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
