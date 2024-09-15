import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

/// Customizable screen material-based.
class ChangelogRawScreen extends StatelessWidget {
  /// Markdown file path.
  ///
  /// Default: "CHANGELOG.md".
  final String? changelogPath;

  /// A custom app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// Widget to be built when the file is loading.
  final Widget Function(BuildContext context) onLoading;

  /// Widget to be built when the file isload fails.
  final Widget Function(BuildContext context) onError;

  /// Builder that exposes the [Markdown] to be renderer.
  ///
  /// Note: [Markdown] inherits from [Markdown].
  final Widget Function(BuildContext context, Widget markdown) bodyBuilder;

  /// Raw screen constructor.
  const ChangelogRawScreen({
    super.key,
    this.appBar,
    this.changelogPath,
    required this.onLoading,
    required this.onError,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final path = changelogPath ?? defaultChangelogPath;

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: rootBundle.loadString(path),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return onLoading.call(context);
          }

          if (snapshot.hasError) {
            return onError.call(context);
          }

          final scrollController = ScrollController();
          final markdown = Markdown(
            controller: scrollController,
            data: snapshot.data!,
          );
          return Scrollbar(
            controller: scrollController,
            child: bodyBuilder.call(context, markdown),
          );
        },
      ),
    );
  }
}
