import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../shared.dart';

class CupertinoChangelogScreen extends StatelessWidget {
  final Widget? middle;
  final bool automaticallyImplyLeading;
  final bool automaticallyImplyMiddle;
  final String? changelogPath;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context)? onError;
  final Widget Function(BuildContext context, Widget markdown)? bodyBuilder;

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
