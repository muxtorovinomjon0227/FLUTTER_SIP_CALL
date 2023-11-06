import 'package:flutter/material.dart';
import 'package:sip_ua/sip_ua.dart';

class RegisterWidget extends StatefulWidget {
  final SIPUAHelper _helper;
  RegisterWidget(this._helper, {Key? key}) : super(key: key);
  @override
  _MyRegisterWidget createState() => _MyRegisterWidget();
}

class _MyRegisterWidget extends State<RegisterWidget>
    implements SipUaHelperListener {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _wsUriController = TextEditingController();
  final TextEditingController _sipUriController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _authorizationUserController = TextEditingController();
  final Map<String, String> _wsExtraHeaders = {
    'Origin': 'wss://cld.alovoice.uz',
    'Host': 'cld.alovoice.uz:61040'
  };
  late RegistrationState _registerState;

  SIPUAHelper get helper => widget._helper;

  @override
  initState() {
    super.initState();
    _registerState = helper.registerState;
    helper.addSipUaHelperListener(this);
  }

  @override
  deactivate() {
    super.deactivate();
    helper.removeSipUaHelperListener(this);
  }

  @override
  void registrationStateChanged(RegistrationState state) {
    setState(() {
      _registerState = state;
    });
  }

  void _alert(BuildContext context, String alertFieldName) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$alertFieldName is empty'),
          content: Text('Please enter $alertFieldName!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


   void registeredSip() async {
    UaSettings settings = UaSettings();
    settings.webSocketUrl = 'wss://cld.alovoice.uz:61113/ws';
    settings.webSocketSettings.allowBadCertificate = true;
    settings.webSocketSettings.extraHeaders = {
      'Origin': 'https://cld.alovoice.uz',
      'Host': 'cld.alovoice.uz:61113'
    };
    settings.uri = "2005@cld.alovoice.uz:61113";
    settings.authorizationUser =  "2005";
    settings.password = "3b3d7b";
    settings.displayName = "2005";
    settings.userAgent = 'AloVoice Client v2.17.0';
    settings.dtmfMode = DtmfMode.RFC2833;
    settings.iceGatheringTimeout = 100;
    helper.start(settings);

     // UaSettings settings = UaSettings();
     // settings.webSocketUrl = 'wss://cld.alovoice.uz:61113/ws';
     // settings.webSocketSettings.allowBadCertificate = true;
     // settings.webSocketSettings.extraHeaders = {
     //   'Origin': 'https://cld.alovoice.uz',
     //   'Host': 'cld.alovoice.uz:61113'
     // };
     // settings.uri = "2003@cld.alovoice.uz:61113";
     // settings.authorizationUser =  "2003";
     // settings.password = "95df9e";
     // settings.displayName = "2003";
     // settings.userAgent = 'AloVoice Client v2.17.0';
     // settings.dtmfMode = DtmfMode.RFC2833;
     // settings.iceGatheringTimeout = 100;
     // helper.start(settings);

     // UaSettings settings = UaSettings();
     // settings.webSocketUrl = 'wss://cld.alovoice.uz:61113/ws';
     // settings.webSocketSettings.allowBadCertificate = true;
     // settings.webSocketSettings.extraHeaders = {
     //   // 'Origin': 'https://cld.alovoice.uz',
     //   // 'Host': 'cld.alovoice.uz:61113'
     // };
     // settings.uri = "2004@cld.alovoice.uz:61113";
     // settings.authorizationUser =  "2004";
     // settings.password = "1a8cba";
     // settings.displayName = "2004";
     // settings.userAgent = 'AloVoice Client v2.17.0';
     // settings.dtmfMode = DtmfMode.RFC2833;
     // settings.iceGatheringTimeout = 100;
     // helper.start(settings);
  }



  void _handleSave(BuildContext context) {


    UaSettings settings = UaSettings();

    settings.webSocketUrl = _wsUriController.text;
    settings.webSocketSettings.allowBadCertificate = true;
    //settings.webSocketSettings.userAgent = 'Dart/2.8 (dart:io) for OpenSIPS.';

    settings.uri = _sipUriController.text;
    settings.authorizationUser = _authorizationUserController.text;
    settings.password = _passwordController.text;
    settings.displayName = _displayNameController.text;


    helper.start(settings);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SIP Account"),
        ),
        body: Align(
            alignment: const Alignment(0, 0),
            child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(48.0, 18.0, 48.0, 18.0),
                        child: Center(
                            child: Text(
                          'Register Status: ${EnumHelper.getName(_registerState.state)}',
                          style: const TextStyle(fontSize: 18, color: Colors.black54),
                        )),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(48.0, 18.0, 48.0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('WebSocket:'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0),
                        child: TextFormField(
                          controller: _wsUriController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(46.0, 18.0, 48.0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('SIP URI:'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0),
                        child: TextFormField(
                          controller: _sipUriController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(46.0, 18.0, 48.0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Authorization User:'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0),
                        child: TextFormField(
                          controller: _authorizationUserController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                            hintText:
                                _authorizationUserController.text.isEmpty
                                    ? '[Empty]'
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(46.0, 18.0, 48.0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Password:'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0),
                        child: TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                            hintText: _passwordController.text.isEmpty
                                ? '[Empty]'
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(46.0, 18.0, 48.0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Display Name:'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(48.0, 0.0, 48.0, 0),
                        child: TextFormField(
                          controller: _displayNameController,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
                      child: SizedBox(
                        height: 48.0,
                        width: 160.0,
                        child: MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () => registeredSip(),
                          child: const Text(
                            'Register',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ))
                ])));
  }

  @override
  void callStateChanged(Call call, CallState state) {
    //NO OP
  }

  @override
  void transportStateChanged(TransportState state) {}

  @override
  void onNewMessage(SIPMessageRequest msg) {
    // NO OP
  }

  @override
  void onNewNotify(Notify ntf) {
    // TODO: implement onNewNotify
  }
}
