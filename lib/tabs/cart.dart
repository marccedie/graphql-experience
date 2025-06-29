import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../app_config.dart';

class CartTabs extends StatefulWidget {
  const CartTabs({super.key});

  @override
  State<CartTabs> createState() => _CartTabsState();
}

class _CartTabsState extends State<CartTabs> {
  late final WebViewController? controller;

  @override
  void initState() async {
    super.initState();

    // load our config
    final config = await AppConfig.forEnvironment();
    try {
      controller = WebViewController()
        ..loadRequest(
          Uri.parse("${config.apiUrl}/checkout/cart"),
        );
    } catch (e) {
      controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Shopping Cart"),
      ),
      body: _loadSpecificViewForDesktop(),
    );
  }

  Widget _loadSpecificViewForDesktop() {
    if (controller != null) {
      return WebViewWidget(controller: controller!);
    }
    return const Center(
      child: Text("Can't Found WebView"),
    );
  }
}
