# Examples

## Material example

```dart

import 'package:flutter/material.dart';
import 'package:changelog_widgets/changelog_widgets.dart';

void main() {
  runApp(const MyMaterialApp());
}


class MyMaterialApp extends StatelessWidget {

  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const MaterialScreen(),
    );
  }
}

class MaterialScreen extends StatelessWidget {
  const MaterialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox.square(dimension: gap);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: const Text(goToTheRawScreen),
              onPressed: () {
                final screen = ChangelogRawScreen(
                  onLoading: (_) {
                    return const Center(
                      child: Text('Loading file'),
                    );
                  },
                  onError: (_) {
                    return const Center(
                      child: Text('Error'),
                    );
                  },
                  bodyBuilder: (_, markdown) {
                    return markdown;
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => screen),
                );
              },
            ),
            space,
            ElevatedButton(
              child: const Text(goToTheScreen),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChangelogScreen()),
                );
              },
            ),
            space,
            ElevatedButton(
              child: const Text(showTheDialog),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const ChangelogDialog();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

```