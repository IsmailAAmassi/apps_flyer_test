import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';

import '../injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAppsFlyer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the home page',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Second Page'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> initAppsFlyer() async {
    try {
      final appsflyerSdk = sl<AppsflyerSdk>();
      await appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
      registerAppsFlyerCallback(appsflyerSdk);
    } catch (e) {
      debugPrint("Ismail error $e");
    }
  }

  void registerAppsFlyerCallback(AppsflyerSdk appsflyerSdk) {
    appsflyerSdk.onInstallConversionData((res) {
      debugPrint('Ismail onInstallConversion $res');
    });

    appsflyerSdk.onAppOpenAttribution((res) {
      debugPrint('Ismail res onAppOpenAttribution$res');
      final payload = res['payload'];
      final afDp = payload['af_dp'];
      final deepLink = payload['deep_link_value'];
      if (deepLink != null) {
        debugPrint("Ismail deepLink != null $deepLink");
        Navigator.pushNamed(context, "/second");
      } else {
        debugPrint("Ismail deepLink == null");
      }
    });

    appsflyerSdk.onDeepLinking(
      (DeepLinkResult dp) {
        switch (dp.status) {
          case Status.FOUND:
            debugPrint(dp.deepLink?.toString());
            debugPrint(
                "Ismail deep link value: ${dp.deepLink?.deepLinkValue}");
            Navigator.pushNamed(context, '/second');
            break;
          case Status.NOT_FOUND:
            debugPrint("Ismail deep link not found");
            break;
          case Status.ERROR:
            debugPrint("Ismail deep link error: ${dp.error}");
            break;
          case Status.PARSE_ERROR:
            debugPrint("Ismail deep link status parsing error");
            break;
        }
      },
    );
  }
}
