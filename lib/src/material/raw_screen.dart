import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

class ChangelogRawScreen extends StatelessWidget {
  final String? changelogPath;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context) onError;
  final Widget Function(BuildContext context, Widget markdown) bodyBuilder;

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
