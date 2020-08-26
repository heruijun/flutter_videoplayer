import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_example/provider/providers.dart';
import 'package:flutter_video_example/ui/simple_video_player.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApplication(),
    ),
  );
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: ProviderInjector.providers, child: App());
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video player example'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          switch (orientation) {
            case Orientation.portrait:
              return SimpleVideoPlayer();
            case Orientation.landscape:
              return SimpleVideoPlayer();
          }
          return null;
        },
      ),
    );
  }
}
