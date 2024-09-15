import 'package:flutter/material.dart';

import '../shared.dart';
import 'raw_screen.dart';

/// Changelog screen material-based.
class ChangelogScreen extends StatelessWidget {
  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget that contains a description of the current contents of the app.
  final Widget? title;

  /// Controls whether we should try to imply the leading widget if null.
  final bool automaticallyImplyLeading;

  /// Whether the title should be centered.
  final bool? centerTitle;

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
