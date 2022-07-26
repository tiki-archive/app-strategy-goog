import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:tiki_strategy_google/tiki_strategy_google.dart';

import 'config_log.dart';

Future<void> main() async {
  ConfigLog();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Logger _log = Logger('example app');

  MyApp({Key? key}) : super(key: key) {
  }

  @override
  Widget build(BuildContext context) {
    Logger.root.level = Level.ALL;
    //Logger.root.onRecord.listen((record) =>
        // ignore: avoid_print
        //print('${record.level.name} [${record.loggerName}] ${record.message}'));

    TikiStrategyGoogle notLoggedIn = TikiStrategyGoogle(
        onLink: (model) => _log.finest(model),
        onUnlink: (email) => _log.finest(email),
        redirectUri: 'com.mytiki.app:/oauth',
        iosClientId:
        '240428403253-v4qk9lt2l07cc8am12gggocpbbsjdvl7.apps.googleusercontent.com',
        androidClientId:
        '240428403253-8bof2prkdatnsm8d2msgq2r81r12p5np.apps.googleusercontent.com');
    TikiStrategyGoogle loggedIn = TikiStrategyGoogle.loggedIn(
        displayName: "Test",
        email: "reallylongemailtooverflow@gmail.com",
        token: "your token",
        refreshToken: "refresh token",
        redirectUri: 'test',
        iosClientId: 'test',
        androidClientId: 'test');

    _log.info("Building strat");

    loggedIn.countInbox(onResult: (val) => {
      _log.info("Found ${val} emails")
    }, onFinish: () => {
      _log.info("Finished count")
    });

    List<String> msgIds = [];
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Container(
              color: Colors.grey,
              child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    loggedIn.authButton,
                    const Padding(padding: EdgeInsets.all(10)),
                    notLoggedIn.authButton,
                    const Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                        onPressed: () => loggedIn.sendEmail(
                            body: "test email from google provider",
                            to: "ricardolgrj@yahoo.com.br",
                            subject: "testing email",
                            onResult: (isOk) => isOk
                                ? _log.finest('email sent')
                                : _log.warning('email not sent')),
                        child: const Text('Send test email')),
                    const Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                        onPressed: () {

                          int startingTime = DateTime.now().millisecondsSinceEpoch;
                          int lastReportTime = DateTime.now().millisecondsSinceEpoch;
                          int totalIndexed = 0;

                          notLoggedIn.fetchInbox(
                              onResult: (messages, {page}) async {
                                msgIds.addAll(messages);
                                page = page;
                                _log.fine('fetched ${messages.length} messages');
                                _log.fine('next page $page');

                                double batchRate = messages.length * 1000.0 / (DateTime.now().millisecondsSinceEpoch - lastReportTime);

                                totalIndexed += messages.length;
                                lastReportTime = DateTime.now().millisecondsSinceEpoch;

                                double totalTime = (lastReportTime - startingTime) / 1000.0;
                                double overallRate = totalIndexed / totalTime;

                                _log.info("=====================================");
                                _log.info("> BENCHMARK STATS (INDEXING)");
                                _log.info("> Last Batch Rate: ${batchRate} msgs/sec (${messages.length} messages)");
                                _log.info("> Overall Rate: ${overallRate} msgs/sec");
                                _log.info("> Total Messages Indexed: ${totalIndexed}");
                                _log.info("> Total Time Elapsed: ${totalTime}s");
                                _log.info("=====================================");

                              }, onFinish: () async {
                              _log.fine('finished fetching inbox.');

                              double totalTime = (lastReportTime - startingTime) / 1000.0;
                              double overallRate = totalIndexed / totalTime;

                              _log.info("=====================================");
                              _log.info("> BENCHMARK STATS (INDEXING)");
                              _log.info("> indexing has been completed.");
                              _log.info("> ");
                              _log.info("> Overall Rate: ${overallRate} msgs/sec");
                              _log.info("> Total Messages Indexed: ${totalIndexed}");
                              _log.info("> Total Time Elapsed: ${totalTime}s");
                              _log.info("=====================================");

                          });
                        },
                        child: const Text('Fetch Inbox')),
                    const Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                        onPressed: () {

                          int startingTime = DateTime.now().millisecondsSinceEpoch;
                          int lastReportTime = DateTime.now().millisecondsSinceEpoch;
                          int totalFetched = 0;

                          notLoggedIn.fetchMessages(
                              messageIds: msgIds,
                              onResult: (message) async {
                                _log.fine('fetched message id ${message.extMessageId} - $message');

                                totalFetched += 1;

                                if (totalFetched % 10 == 0) {
                                  double batchRate = 10 * 1000.0 / (DateTime.now().millisecondsSinceEpoch - lastReportTime);

                                  lastReportTime = DateTime.now().millisecondsSinceEpoch;
                                  double totalTime = (lastReportTime - startingTime) / 1000.0;
                                  double overallRate = totalFetched / totalTime;

                                  _log.info("=====================================");
                                  _log.info("> BENCHMARK STATS (FETCHING)");
                                  _log.info("> Last Batch Rate: ${batchRate} msgs/sec (10 messages)");
                                  _log.info("> Overall Rate: ${overallRate} msgs/sec");
                                  _log.info("> Total Messages Fetched: ${totalFetched}");
                                  _log.info("> Total Time Elapsed: ${totalTime}s");
                                  _log.info("=====================================");
                                }


                              },
                              onFinish: () async {
                                _log.fine('finished fetching messages.');

                                double totalTime = (lastReportTime - startingTime) / 1000.0;
                                double overallRate = totalFetched / totalTime;

                                _log.info("=====================================");
                                _log.info("> BENCHMARK STATS (FETCHING)");
                                _log.info("> fetching has been completed.");
                                _log.info("> ");
                                _log.info("> Overall Rate: ${overallRate} msgs/sec");
                                _log.info("> Total Messages Fetched: ${totalFetched}");
                                _log.info("> Total Time Elapsed: ${totalTime}s");
                                _log.info("=====================================");
                              });

                        },
                        child: const Text('Fetch Messages'))
                  ]))),
        ));
  }
}
