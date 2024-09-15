import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

class ChangelogDialog extends StatelessWidget {
  final String? changelogPath;
  final bool showIcon;
  final Widget? icon;
  final Widget? title;
  final Widget Function(BuildContext context, Widget markdown)? bodyBuilder;
  final Widget? okButton;

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
