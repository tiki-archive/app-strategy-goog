/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'auth_model_status.dart';
import 'auth_service.dart';
import 'auth_view_layout_link.dart';
import 'auth_view_layout_linked.dart';

class AuthViewLayout extends StatelessWidget {
  const AuthViewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthService service = Provider.of<AuthService>(context);

    switch (service.model.linkStatus) {
      case AuthModelStatus.LINKED:
        return const AuthViewLayoutLinked();
      case AuthModelStatus.PRE_PRESENT_OAUTH:
        return AlertDialog(
          title: Text("Attention"),
          content: const Text("You will be prompted to connect your email inbox to the TIKI app. You must click the check boxes so data NFTs can be minted for you."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => service.controller.signOut(),
            ),
            TextButton(
              child: const Text("Ok (Sign In)"),
              onPressed: () => service.controller.signIn(),
            ),
          ],
        );
      case AuthModelStatus.PENDING_DENIED_SCOPES:
        return AlertDialog(
          title: const Text("Attention"),
          content: const Text("You did not provide access to your inbox! You must click the check boxes to connect your email to the TIKI app."),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => service.controller.signOut(),
            ),
            TextButton(
              child: const Text("Try Again"),
              onPressed: () => service.controller.signIn(),
            ),
          ],
        );
      case AuthModelStatus.UNLINKED:
      default:
        return const AuthViewLayoutLink();
    }
  }
}
