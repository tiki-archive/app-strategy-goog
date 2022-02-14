import 'package:flutter/material.dart';
import 'package:google_provider/google_provider.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _log = Logger('example app');

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleProvider googleProvider = GoogleProvider(
      onLink: (model) => _log.finest(model),
      onUnlink: (email) => _log.finest(email),
      onSee: (data) => _log.finest(data),
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
            color: Colors.grey,
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      googleProvider.accountWidget(),
                      const Padding(padding: EdgeInsets.all(20)),
                      TextButton(
                          onPressed: () => googleProvider.sendEmail(
                              body : "test email from google provider",
                              to : "ricardolgrj@yahoo.com.br",
                              subject : "testing email",
                              onResult : (isOk) => isOk ?
                                  _log.finest('email sent') :
                                  _log.warning('email not sent')
                          ),
                          child: const Text('Send test email')
                      )])
            )),
      ));
  }
}