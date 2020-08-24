import 'package:flutter/material.dart';
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
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        key: const ValueKey<String>('home_page'),
        appBar: AppBar(
          title: const Text('Video player example'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cloud),
                text: "Remote",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SimpleVideoPlayer(),
          ],
        ),
      ),
    );
  }
}
