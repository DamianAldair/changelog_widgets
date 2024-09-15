import 'package:flutter/material.dart';

import '../shared.dart';
import 'raw_screen.dart';

class ChangelogScreen extends StatelessWidget {
  final Widget? title;
  final bool automaticallyImplyLeading;
  final bool? centerTitle;
  final String? changelogPath;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context)? onError;
  final Widget Function(BuildContext context, Widget markdown)? bodyBuilder;

  const ChangelogScreen({
    super.key,
    this.title,
    this.automaticallyImplyLeading = true,
    this.centerTitle,
    this.changelogPath,
    this.onLoading,
    this.onError,
    this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final path = changelogPath ?? defaultChangelogPath;

    return ChangelogRawScreen(
      changelogPath: path,
      appBar: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title ?? const Text(widgetTitle),
        centerTitle: centerTitle,
      ),
      onLoading:
          onLoading ?? (_) => const Center(child: CircularProgressIndicator()),
      onError:
          onError ?? (_) => Center(child: Text(getDefaultErrorMessage(path))),
      bodyBuilder: bodyBuilder ?? (_, markdown) => markdown,
    );
  }
}
