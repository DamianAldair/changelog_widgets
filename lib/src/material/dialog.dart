import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

/// Changelog dialog material-based.
class ChangelogDialog extends StatelessWidget {
  /// Markdown file path.
  ///
  /// Default: "CHANGELOG.md".
  final String? changelogPath;

  /// Whether the icon should be displayed.
  final bool showIcon;

  /// An optional icon to display at the top of the dialog.
  ///
  /// Typically, an [Icon] widget. Providing an icon centers the [title]'s text.
  final Widget? icon;

  /// The (optional) title of the dialog is displayed in a large font
  /// at the top of the dialog, below the (optional) [icon].
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// Builder that exposes the [Markdown] to be renderer.
  ///
  /// If the builder is `null`, the [Markdown] will be built directly.
  ///
  /// Note: [Markdown] inherits from [Markdown].
  final Widget Function(BuildContext context, Widget markdown)? bodyBuilder;

  /// The (optional) button that is displayed at the bottom
  /// of the dialog with an [OverflowBar].
  final Widget? okButton;

  /// Changelog dialog constructor.
  const ChangelogDialog({
    super.key,
    this.changelogPath,
    this.showIcon = true,
    this.icon,
    this.title,
    this.bodyBuilder,
    this.okButton,
  });

  @override
  Widget build(BuildContext context) {
    final path = changelogPath ?? defaultChangelogPath;

    return AlertDialog(
      icon: !showIcon ? null : icon ?? const Icon(Icons.update),
      title: title ?? const Text(widgetTitle),
      content: FutureBuilder(
        future: rootBundle.loadString(path),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(getDefaultErrorMessage(path)));
          }

          final scrollController = ScrollController();
          final markdown = Markdown(
            controller: scrollController,
            data: snapshot.data!,
          );
          return Scrollbar(
            controller: scrollController,
            child: bodyBuilder?.call(context, markdown) ?? markdown,
          );
        },
      ),
      actions: [
        okButton ??
            TextButton(
              child: Text(MaterialLocalizations.of(context).okButtonLabel),
              onPressed: () => Navigator.pop(context),
            ),
      ],
    );
  }
}
