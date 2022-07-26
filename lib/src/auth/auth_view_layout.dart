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
      case AuthModelStatus.PENDING_REQUESTING_SCOPES:
        return const Text(
            "Loading..."
        );
      case AuthModelStatus.PENDING_DENIED_SCOPES:
        return AlertDialog(
          title: const Text("Scopes denied"),
          content: const Text("You need to click the check boxes to scan your inbox ."),
          actions: [
            TextButton(
              child: const Text("Try Again"),
              onPressed: () => service.controller.requestNeededScopes(),
            ),
            TextButton(
              child: const Text("Log Out"),
              onPressed: () => service.model.linkStatus = AuthModelStatus.UNLINKED,
            ),
          ],
        );
      case AuthModelStatus.UNLINKED:
      default:
        return const AuthViewLayoutLink();
    }
  }
}
