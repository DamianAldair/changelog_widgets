import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

/// Changelog screen cupertino-based.
class CupertinoChangelogScreen extends StatelessWidget {
  /// Widget to place in the middle of the navigation bar. Normally a title or
  /// a segmented control.
  ///
  /// If null and [automaticallyImplyMiddle] is true, an appropriate [Text]
  /// title will be created if the current route is a [CupertinoPageRoute] and
  /// has a `title`.
  final Widget? middle;

  /// Controls whether we should try to imply the leading widget if null.
  final bool automaticallyImplyLeading;

  /// Controls whether we should try to imply the middle widget if null.
  final bool automaticallyImplyMiddle;

  /// Markdown file path.
  ///
  /// Default: "CHANGELOG.md".
  final String? changelogPath;

  /// Widget to be built when the file is loading.
  final Widget Function(BuildContext context)? onLoading;

  /// Widget to be built when the file load fails.
  final Widget Function(BuildContext context)? onError;

  /// Builder that exposes the [Markdown] to be renderer.
  ///
  /// Note: [Markdown] inherits from [Markdown].
  final Widget Function(BuildContext context, Widget markdown)? bodyBuilder;

  /// Changelog screen constructor.
  const CupertinoChangelogScreen({
    super.key,
    this.middle,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.changelogPath,
    this.onLoading,
    this.onError,
    this.bodyBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final path = changelogPath ?? defaultChangelogPath;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        middle: middle ?? const Text(widgetTitle),
      ),
      child: SafeArea(
        child: FutureBuilder(
          future: rootBundle.loadString(path),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return onLoading?.call(context) ??
                  const Center(
                    child: CupertinoActivityIndicator(),
                  );
            }

            if (snapshot.hasError) {
              return onError?.call(context) ??
                  Center(
                    child: Text(getDefaultErrorMessage(path)),
                  );
            }

            final scrollController = ScrollController();
            final markdown = Markdown(
              controller: scrollController,
              data: snapshot.data!,
            );
            return CupertinoScrollbar(
              controller: scrollController,
              child: bodyBuilder?.call(context, markdown) ?? markdown,
            );
          },
        ),
      ),
    );
  }
}
