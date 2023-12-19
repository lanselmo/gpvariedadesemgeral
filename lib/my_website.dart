import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyWebsite extends StatefulWidget {
  const MyWebsite({Key? key}) : super(key: key);

  @override
  State<MyWebsite> createState() => MyWebsiteState();
}

class MyWebsiteState extends State<MyWebsite> {
  Completer<void>? _refreshCompleter;
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  bool _isConnected = true;
  int _selectedIndex = 0;
  PullToRefreshController? refreshController;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();

    // Show to load end screw end Push Refresh Indication.
    refreshController = PullToRefreshController(
        onRefresh: () {
          inAppWebViewController.reload();
        },
        options: PullToRefreshOptions(
            color: Colors.white,
            backgroundColor: Colors.red
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Stack(
            children: [
              _buildWebView(),
              if (_progress < 1) _buildLoadingIndicator(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildWebView() {
    return InAppWebView(
      pullToRefreshController: refreshController,
      initialUrlRequest: URLRequest(
        url: Uri.parse("https://gpvariedadesemgeral.lojavirtualnuvem.com.br/"),
      ),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          supportZoom: false,
          transparentBackground: true,
        ),
      ),
      onWebViewCreated: (InAppWebViewController controller) {
        inAppWebViewController = controller;
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          _progress = progress / 100;
        });
      },
      onLoadError: (InAppWebViewController controller, Uri? url, int code,
          String message) {
        setState(() {
          _isConnected = false;
        });
      },
      onLoadStop: (InAppWebViewController controller, Uri? url) {
        if (!_refreshCompleter!.isCompleted) {
          _refreshCompleter!.complete();
          _refreshCompleter = Completer<void>();
          refreshController!.endRefreshing();
        }
        _onPageLoaded(url);
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: LoadingAnimationWidget.prograssiveDots(
        color: const Color(0xffca5a5b),
        size: 50,
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(MaterialSymbols.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialSymbols.search_filled_outlined),
          label: 'Buscar',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialSymbols.filter_alt_outlined),
          label: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialSymbols.help_outlined),
          label: 'Contato',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      onTap: _onBottomNavTapped,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }

  Future<bool> _onWillPop() async {
    if (!_isConnected) {
      return true;
    }
    var isLastPage = await inAppWebViewController.canGoBack();
    if (isLastPage) {
      inAppWebViewController.goBack();
      return false;
    }
    return true;
  }

  void _onBottomNavTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });

    // Load different URLs based on the selected index
    if (index == 0) {
      loadUrl("https://gpvariedadesemgeral.lojavirtualnuvem.com.br/");
    } else if (index == 1) {
      loadUrl("https://gpvariedadesemgeral.lojavirtualnuvem.com.br/search/?q=");
    } else if (index == 2) {
      loadUrl("https://gpvariedadesemgeral.lojavirtualnuvem.com.br/produtos/");
    } else if (index == 3) {
      loadUrl("https://gpvariedadesemgeral.lojavirtualnuvem.com.br/contato/");
    }
  }

  void loadUrl(String url) {
    inAppWebViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
  }

  void _onPageLoaded(Uri? url) {
    if (url?.toString() ==
        "https://gpvariedadesemgeral.lojavirtualnuvem.com.br/") {
      _updateSelectedIndex(0);
    } else if (url?.toString() ==
        "https://gpvariedadesemgeral.lojavirtualnuvem.com.br/search/?q=") {
      _updateSelectedIndex(1);
    } else if (url?.toString() == "https://gpvariedadesemgeral.lojavirtualnuvem.com.br/produtos/") {
      _updateSelectedIndex(2);
    } else if (url?.toString() ==
        "https://gpvariedadesemgeral.lojavirtualnuvem.com.br/contato/") {
      _updateSelectedIndex(3);
    }
  }

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
