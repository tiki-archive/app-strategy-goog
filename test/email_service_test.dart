import 'package:flutter_test/flutter_test.dart';
import 'package:tiki_strategy_google/src/auth/auth_service.dart';
import 'package:tiki_strategy_google/src/email/email_model_msg_header.dart';
import 'package:tiki_strategy_google/src/email/email_service.dart';

main(){
  test("Get e-mail from gmail alias", () {
    String email = "someone@gmail.com";
    EmailService emailService = EmailService(AuthService(redirectUri: ''));
    expect(emailService.toEmail([
      EmailModelMsgHeader(name:"To", value: "someone@gmail.com")
    ], email), email);
    expect(emailService.toEmail([
      EmailModelMsgHeader(name:"To", value: "someone+alias1@gmail.com")
    ], email), email);
    expect(emailService.toEmail([
      EmailModelMsgHeader(name:"To", value: "someone+alias2+wrong@gmail.com")
    ], email), email);
    expect(emailService.toEmail([
      EmailModelMsgHeader(name:"To", value: "someone+alias2+wrong@gmail.com")
    ],email), email);
  });
}