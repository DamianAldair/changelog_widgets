import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

/// Customizable screen cupertino-based.
class CupertinoChangelogRawScreen extends StatelessWidget {
  /// Markdown file path.
  ///
  /// Default: "CHANGELOG.md".
  final String? changelogPath;

  /// The [navigationBar], typically a [CupertinoNavigationBar],
  /// is drawn at the top of the screen.
  final ObstructingPreferredSizeWidget? navigationBar;

  /// Whether the child should be sorrounded by [SafeArea].
  final bool useSafeArea;

  /// Widget to be built when the file is loading.
  final Widget Function(BuildContext context) onLoading;

  /// Widget to be built when the file load fails.
  final Widget Function(BuildContext context) onError;

  /// Builder that exposes the [Markdown] to be renderer.
  ///
  /// Note: [Markdown] inherits from [Markdown].
  final Widget Function(BuildContext context, Widget markdown) bodyBuilder;

  /// Raw screen constructor.
  const CupertinoChangelogRawScreen({
    super.key,
    this.changelogPath,
    this.navigationBar,
    this.useSafeArea = false,
    required this.onLoading,
    required this.onError,
    required this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final path = changelogPath ?? defaultChangelogPath;

    Widget child = FutureBuilder(
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
        return CupertinoScrollbar(
          controller: scrollController,
          child: bodyBuilder.call(context, markdown),
        );
      },
    );

    if (useSafeArea) {
      child = SafeArea(
        child: child,
      );
    }

    return CupertinoPageScaffold(
      navigationBar: navigationBar,
      child: child,
    );
  }
}
