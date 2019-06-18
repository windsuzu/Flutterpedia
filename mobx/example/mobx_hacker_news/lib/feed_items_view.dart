import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_hacker_news/hacker_news_store.dart';

class FeedItemsView extends StatelessWidget {
  FeedItemsView(this.store, this.type);

  final HackerNewsStore store;
  final FeedType type;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future = type == FeedType.latest
          ? store.latestItemsFuture
          : store.topItemsFuture;

      switch (future.status) {
        case FutureStatus.pending:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('Loading items...'),
            ],
          );

        case FutureStatus.rejected:
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Failed to load items.',
                style: TextStyle(color: Colors.red),
              ),
              RaisedButton(
                child: const Text('Tap to try again'),
                onPressed: _refresh,
              )
            ],
          );
        case FutureStatus.fulfilled:
          final List<FeedItem> items = future.result;

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final item = items[index];
                  return ListTile(
                    leading: Text(
                      '${item.points}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '- ${item.user}, ${item.commentsCount} comment(s)'),
                    onTap: () => store.openUrl(item.url),
                  );
                }),
          );
      }
    });
  }

  Future _refresh() =>
      (type == FeedType.latest) ? store.fetchLatest() : store.fetchTop();
}
