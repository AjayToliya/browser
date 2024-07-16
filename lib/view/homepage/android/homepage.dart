import 'package:browser/provider/Connection_provider.dart';
import 'package:browser/provider/brower.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../../model/data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? inAppWebViewController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).checkInternet();
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (inAppWebViewController != null) {
          await inAppWebViewController!.loadUrl(
            urlRequest: URLRequest(
              url: await inAppWebViewController?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browser',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) {
              return <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () {
                    Navigator.of(context).pushNamed('bookmark');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.bookmark, color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text("View Bookmarks"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertBox();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.screen_search_desktop_outlined,
                          color: Colors.blueAccent),
                      SizedBox(width: 10),
                      Text("Change Search Engine"),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ConnectivityProvider>(
              builder: (context, connectivityProvider, _) {
                if (connectivityProvider.isInternet) {
                  return InAppWebView(
                    pullToRefreshController: pullToRefreshController,
                    initialUrlRequest: URLRequest(
                      url: WebUri("https://google.com/"),
                    ),
                    onLoadStart: (controller, url) {
                      inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) async {
                      await pullToRefreshController!.endRefreshing();
                    },
                  );
                } else {
                  return Center(
                    child: Text("No Internet"),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search or type web address',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    ),
                    onSubmitted: (value) async {
                      String url = value;
                      if (!url.startsWith('http')) {
                        url = 'https://www.google.com/search?q=' + url;
                      }
                      if (inAppWebViewController != null) {
                        await inAppWebViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri(url),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      String url = searchController.text;
                      if (!url.startsWith('http')) {
                        url = 'https://www.google.com/search?q=' + url;
                      }
                      if (inAppWebViewController != null) {
                        await inAppWebViewController!.loadUrl(
                          urlRequest: URLRequest(
                            url: WebUri(url),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    if (inAppWebViewController != null) {
                      await inAppWebViewController!.loadUrl(
                        urlRequest: URLRequest(
                          url: WebUri("https://google.com/"),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    WebUri? txt = await inAppWebViewController!.getUrl();
                    Bookmark.urls.add(txt.toString());
                    Bookmark.convertUrl();
                    print(Bookmark.urls.length.toString());
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    if (inAppWebViewController != null) {
                      if (await inAppWebViewController!.canGoBack()) {
                        await inAppWebViewController!.goBack();
                      }
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    if (inAppWebViewController != null) {
                      await inAppWebViewController!.reload();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () async {
                    if (inAppWebViewController != null) {
                      if (await inAppWebViewController!.canGoForward()) {
                        await inAppWebViewController!.goForward();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  const AlertBox({Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Engine'),
      content: Consumer<SearchEngineProvider>(
        builder: (BuildContext context, SearchEngineProvider value, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Google'),
                value: value.strGoogle,
                groupValue: value.selectedRadio,
                onChanged: (val) {
                  value.handleRadioValueChange(val!, context);
                },
              ),
              RadioListTile<String>(
                title: Text('Yahoo'),
                value: value.strYahoo,
                groupValue: value.selectedRadio,
                onChanged: (val) {
                  value.handleRadioValueChange(val!, context);
                },
              ),
              RadioListTile<String>(
                title: Text('Bing'),
                value: value.strBing,
                groupValue: value.selectedRadio,
                onChanged: (val) {
                  value.handleRadioValueChange(val!, context);
                },
              ),
              RadioListTile<String>(
                title: Text('Duck Duck Go'),
                value: value.strDuckDuckGo,
                groupValue: value.selectedRadio,
                onChanged: (val) {
                  value.handleRadioValueChange(val!, context);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
