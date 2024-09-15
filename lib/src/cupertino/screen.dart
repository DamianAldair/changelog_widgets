import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../changelog_widgets.dart';
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

    return CupertinoChangelogRawScreen(
      changelogPath: path,
      navigationBar: CupertinoNavigationBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        automaticallyImplyMiddle: automaticallyImplyMiddle,
        middle: middle ?? const Text(widgetTitle),
      ),
      useSafeArea: true,
      onLoading:
          onLoading ?? (_) => const Center(child: CupertinoActivityIndicator()),
      onError:
          onError ?? (_) => Center(child: Text(getDefaultErrorMessage(path))),
      bodyBuilder: bodyBuilder ?? (_, markdown) => markdown,
    );
  }
}
