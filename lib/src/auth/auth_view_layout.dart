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
          title: Text("You will need to click check boxes ${service.model.linkStatus}"),
          content: const Text("Providing access from google allows you to scan your inbox."),
          actions: [
            TextButton(
              child: const Text("Proceed to sign in"),
              onPressed: () => service.controller.signIn(),
            ),
            TextButton(
              child: const Text("No Thanks"),
              onPressed: () => service.controller.signOut(),
            ),
          ],
        );
      case AuthModelStatus.PENDING_DENIED_SCOPES:
        return AlertDialog(
          title: const Text("Scopes denied"),
          content: const Text("You need to click the check boxes to scan your inbox ."),
          actions: [
            TextButton(
              child: const Text("Try Again"),
              onPressed: () => service.controller.signIn(),
            ),
            TextButton(
              child: const Text("No Thanks"),
              onPressed: () => service.controller.signOut(),
            ),
          ],
        );
      case AuthModelStatus.UNLINKED:
      default:
        return const AuthViewLayoutLink();
    }
  }
}
