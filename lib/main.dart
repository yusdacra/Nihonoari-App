import 'package:flutter/material.dart';
import 'party.dart';
import 'package:flutter/gestures.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/LICENSES.txt');
}

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class hiraDialog extends StatefulWidget {
  @override
  _hiraDialogState createState() => _hiraDialogState();
}

class kataDialog extends StatefulWidget {
  @override
  _kataDialogState createState() => _kataDialogState();
}

Map<String, bool> _hirasol = {
  'あ い う え お': true,
  'か き く け こ': true,
  'さ し	す せ そ': true,
  'た ち つ て と': true,
  'な に ぬ ね の': true,
  'は ひ ふ へ ほ': true,
  'ま み む め も': true,
  'や ゆ よ': true,
  'ら り る れ ろ': true,
  'わ を': true,
  'ん': true
};

Map<String, bool> _katasol = {
  'ア イ ウ エ オ': true,
  'カ キ ク ケ コ': true,
  'サ シ ス セ ソ': true,
  'タ チ ツ テ ト': true,
  'ナ ニ ヌ ネ ノ': true,
  'ハ ヒ フ ヘ ホ': true,
  'マ ミ ム メ モ': true,
  'ヤ ユ ヨ': true,
  'ラ リ ル レ ロ': true,
  'ワ ヲ': true,
  'ン': true,
};

class _hiraDialogState extends State<hiraDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Hiragana set',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      content: Container(
        width: double.maxFinite,
        child: new Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: new ListView(
            children: _hirasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                activeColor: Colors.red,
                value: _hirasol[key],
                onChanged: (bool value) {
                  setState(() {
                    _hirasol[key] = value;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Icon(
            Icons.done,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class _kataDialogState extends State<kataDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        'Katakana set',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: new ListView(
            children: _katasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: _katasol[key],
                activeColor: Colors.red,
                onChanged: (bool value) {
                  setState(() {
                    _katasol[key] = value;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Icon(
            Icons.done,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyApp> {
  bool _katakana = false;
  bool _hiragana = false;

  bool _isButtonDisabled = true;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _katakanaChanged(bool value) => setState(() => _katakana = value);

  void _hiraganaChanged(bool value) => setState(() => _hiragana = value);

  void __isButtonDisabledChanged() {
    _isButtonDisabled = _katakana || _hiragana ? false : true;
  }

  void _showLicense() async {
    String data = await loadAsset();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Licenses"),
          content: new SingleChildScrollView(
            child: Text(data),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Icon(
                Icons.done,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'nihonoari ',
                            style: TextStyle(
                              fontFamily: 'AppleTP',
                              fontSize: 30.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'project',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(
                            text: 'LICENSES',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _showLicense();
                              },
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: new Column(children: <Widget>[
                    new CheckboxListTile(
                      value: _hiragana,
                      onChanged: (value) async {
                        if (value) {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return hiraDialog();
                            },
                          );
                        }
                        if (!_hirasol.containsValue(true)) {
                          _hiraganaChanged(false);
                        } else {
                          _hiraganaChanged(value);
                        }
                        __isButtonDisabledChanged();
                      },
                      title: new Text(
                        'Hiragana',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        'Include Hiragana syllabary',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      secondary: new Icon(
                        Icons.font_download,
                        color: Colors.white,
                      ),
                      activeColor: Colors.red,
                    ),
                    new CheckboxListTile(
                      value: _katakana,
                      onChanged: (value) async {
                        if (value) {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return kataDialog();
                            },
                          );
                        }

                        if (!_katasol.containsValue(true)) {
                          _katakanaChanged(false);
                        } else {
                          _katakanaChanged(value);
                        }
                        __isButtonDisabledChanged();
                      },
                      title: new Text(
                        'Katakana',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        'Include Katakana syllabary',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      secondary: new Icon(
                        Icons.font_download,
                        color: Colors.white,
                      ),
                      activeColor: Colors.red,
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Center(
                          child: new RaisedButton(
                            padding: const EdgeInsets.all(8.0),
                            textColor: Colors.white,
                            color: Colors.red,
                            disabledColor: Colors.white,
                            onPressed: _isButtonDisabled
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Party(
                                                h: _hiragana,
                                                hv: _hirasol,
                                                k: _katakana,
                                                kv: _katasol,
                                              )),
                                    );
                                  },
                            child: new Text(
                                _isButtonDisabled ? "Select one" : "Start"),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
