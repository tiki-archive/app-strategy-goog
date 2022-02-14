import 'dart:convert';

import 'package:google_provider/src/google_provider_service.dart';
import 'package:google_provider/src/model/email/google_provider_model_email_msg_header.dart';
import 'package:google_provider/src/model/email/google_provider_model_email_msgs.dart';
import 'package:google_provider/src/repository/google_provider_repository_email.dart';
import 'package:httpp/httpp.dart';
import 'package:logging/logging.dart';

import 'model/email/google_provider_model_company.dart';
import 'model/email/google_provider_model_email.dart';
import 'model/email/google_provider_model_email_msg.dart';
import 'model/email/google_provider_model_sender.dart';
import 'model/google_provider_model_error.dart';
import 'package:collection/collection.dart';

class GoogleProviderServiceEmail{

  final Logger _log = Logger('GoogleProviderServiceEmail');
  final GoogleProviderRepositoryEmail _repositoryEmail;
  final GoogleProviderService _service;

  GoogleProviderServiceEmail(this._service) :
    _repositoryEmail = GoogleProviderRepositoryEmail();

  Future<void> fetchInbox({
    DateTime? since,
    required Function(List<String> messagesIds) onResult,
    required Function() onFinish}) {
    return _fetchInbox(
        onFinish: onFinish,
        onResult: onResult,
        since: since);
  }
  
  Future<void> fetchMessages({
        required List<String> messageIds,
        required Function(GoogleProviderModelEmail message) onResult,
        required Function() onFinish}) async {
    List<Future> futures = [];
    for (var messageId in messageIds) {
      futures.add(_repositoryEmail.message(
        client: _service.client,
        accessToken: _service.model.token,
        messageId: messageId,
        onSuccess: (response) {
          GoogleProviderModelEmailMsg message =
            GoogleProviderModelEmailMsg.fromJson(response.body?.jsonBody);
          Map<String, String>? from = _from(message.payload?.headers);
          onResult(GoogleProviderModelEmail(
              extMessageId: message.id,
              receivedDate: message.internalDate,
              openedDate: null, //TODO implement open date detection
              toEmail: _toEmail(message.payload?.headers, _service.model.email!),
              sender: GoogleProviderModelSender(
                  email: from?['email'],
                  name: from?['name'],
                  category: _category(message.labelIds),
                  unsubscribeMailTo:
                  _unsubscribeMailTo(message.payload?.headers),
                  unsubscribed: false,
                  company: GoogleProviderModelCompany(
                      domain:
                      GoogleProviderModelCompany.domainFromEmail(from?['email'])))));
        },
        onResult: (response) {
          _log.warning(
              'Fetch message $messageId failed with statusCode ${response.statusCode}');
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
        },
        onError: (error) {
          _log.warning('Fetch message $messageId failed with error $error');
        }));
    }
    await Future.wait(futures);
    onFinish();
  }

  Future<void> sendEmail({
    String? body,
    required String to,
    String? subject,
    Function(bool success)? onResult
  }) async {
    String message = '''
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit
to: $to
from: me
subject: $subject

<!DOCTYPE html PUBLIC “-//W3C//DTD XHTML 1.0 Transitional//EN” “https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd”>
<html xmlns=“https://www.w3.org/1999/xhtml”>
<head>
<title>$subject</title>
<meta http–equiv=“Content-Type” content=“text/html; charset=UTF-8” />
<meta http–equiv=“X-UA-Compatible” content=“IE=edge” />
<meta name=“viewport” content=“width=device-width, initial-scale=1.0 “ />
</head>
<body class=“em_body” style=“margin:0px; padding:0px;”> 
$body
<br />
*Sent via http://www.mytiki.com. Join the data ownership<br />
revolution today.<br />
</body>
</html>
''';

    String base64Email = base64UrlEncode(utf8.encode(message));
    return _repositoryEmail.send(
        client: _service.client,
        accessToken: _service.model.token,
        message: HttppBody.fromJson(
            GoogleProviderModelEmailMsg(raw: base64Email).toJson()),
        onSuccess: (response) {
          _log.finest('mail sent to ' + to);
          if (onResult != null) onResult(true);
        },
        onResult: (response) async {
          _log.warning('email to $to failed.');
          _handleUnauthorized(response);
          _handleTooManyRequests(response);
          if (onResult != null) onResult(false);
        },
        onError: (error) {
          _log.warning('email to  $to failed.');
          if (onResult != null) onResult(false);
        });
  }

  Map<String, String>? _from(List<GoogleProviderModelEmailMsgHeader>? headers) {
    if (headers != null) {
      for (GoogleProviderModelEmailMsgHeader header in headers) {
        if (header.name?.trim() == 'From') {
          Map<String, String> rsp = {};
          if (header.value != null) {
            List<String> values = header.value!.split('<');
            if (values.length == 1) {
              rsp['email'] = values[0].trim();
            } else if (values.length == 2) {
              rsp['email'] = values[1].trim().replaceAll('>', '');
              rsp['name'] = values[0].trim().replaceAll("\"", '');
            }
          }
          return rsp;
        }
      }
    }
  }

  String? _unsubscribeMailTo(List<GoogleProviderModelEmailMsgHeader>? headers) {
    if (headers != null) {
      for (GoogleProviderModelEmailMsgHeader header in headers) {
        if (header.name?.trim() == 'List-Unsubscribe' && header.value != null) {
          String removeCaret =
          header.value!.replaceAll('<', '').replaceAll(">", '');
          List<String> splitMailTo = removeCaret.split('mailto:');
          if (splitMailTo.length > 1) return splitMailTo[1].split(',')[0];
        }
      }
    }
  }

  String? _category(List<String>? labelIds) {
    if (labelIds != null) {
      String? categoryLabel =
      labelIds.firstWhereOrNull((label) => label.contains("CATEGORY_"));
      if (categoryLabel != null) {
        return categoryLabel.replaceFirst('CATEGORY_', '');
      }
    }
  }

  String? _toEmail(List<GoogleProviderModelEmailMsgHeader>? headers, String expected) {
    if (headers != null) {
      for (GoogleProviderModelEmailMsgHeader header in headers) {
        if (header.name?.trim() == 'To' && header.value != null) {
          String headerEmail = header.value!.contains("<")
              ? header.value!
              .split("<")
              .toList()[1]
              .replaceFirst(">", "")
              .trim()
              : header.value!;
          return headerEmail.trim().toLowerCase();
        }
      }
    }
    return expected;
  }

  Future<void> _fetchInbox({
    Function? onFinish,
    String? pageToken,
    DateTime? since,
    required Function(List<String> messagesIds) onResult}) {
    return _repositoryEmail.messageId(
      client: _service.client,
      accessToken: _service.model.token,
      filter: _buildFiler(after: since, maxResults: 500, pageToken: pageToken),
      onSuccess: (response) {
        GoogleProviderModelEmailMsgs messages =
          GoogleProviderModelEmailMsgs.fromJson(response.body?.jsonBody);
        List<String> messagesIds = messages.messages?.map(
                (m) => m.id ?? "").toList() ?? List.empty();
        messagesIds.removeWhere((element) => element.isEmpty);
        onResult(messagesIds);
        if (messages.nextPageToken != null) {
          _fetchInbox(
              onResult: onResult,
              pageToken: messages.nextPageToken,
              since: since);
        }else {
          if(onFinish != null) {
            onFinish();
          }
        }
      },
      onResult: (response) {
        _log.warning(
            'Fetch inbox ${_service.model.email} failed with statusCode ${response.statusCode}');
        _handleUnauthorized(response);
        _handleTooManyRequests(response);
      },
      onError: (error) => _log.warning(
          'Fetch inbox ${_service.model.email} failed with error $error'),
    );
  }

  void _handleUnauthorized(HttppResponse response) {
    if (HttppUtils.isUnauthorized(response.statusCode)) {
      _log.warning('Unauthorized. Trying refresh');
      _service.client.denyUntil(response.request!, () async {
        await _service.refreshToken();
        response.request?.headers?.auth(_service.model.token);
      });
    }
  }

  void _handleTooManyRequests(HttppResponse response) {
    if (HttppUtils.isForbidden(response.statusCode)) {
      GoogleProviderModelError error =
        GoogleProviderModelError.fromJson(response.body?.jsonBody['error']);
      error.errors?.forEach((error) {
        if (error.reason == 'rateLimitExceeded') {
          _log.warning('Too many requests. Retry after');
          _service.client.denyFor(response.request!, const Duration(seconds: 1));
          return;
        }
      });
    }
  }

  String _buildFiler(
      {DateTime? after, int maxResults = 500, String? pageToken}) {
    StringBuffer queryBuffer = StringBuffer();

    _appendQuery(queryBuffer, 'maxResults=$maxResults');

    if (pageToken != null) _appendQuery(queryBuffer, 'pageToken=$pageToken');

    if (after != null) {
      int secondsSinceEpoch = (after.millisecondsSinceEpoch / 1000).floor();
      _appendQuery(queryBuffer, 'q=after:' + secondsSinceEpoch.toString());
    }
    return queryBuffer.toString();
  }

  StringBuffer _appendQuery(StringBuffer queryBuffer, String append) {
    if (queryBuffer.isNotEmpty) {
      queryBuffer.write('&');
    }
    queryBuffer.write(append);
    return queryBuffer;
  }

}