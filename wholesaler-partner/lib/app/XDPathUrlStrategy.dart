// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
//
// class XDPathUrlStrategy extends HashUrlStrategy {
//   /// Creates an instance of [PathUrlStrategy].
//   ///
//   /// The [PlatformLocation] parameter is useful for testing to mock out browser
//   /// interactions.
//   XDPathUrlStrategy([
//     super.platformLocation,
//   ]) : _basePath = stripTrailingSlash(extractPathname(checkBaseHref(
//     platformLocation.getBaseHref(),
//   )));
//
//   final String _basePath;
//
//   @override
//   String prepareExternalUrl(String internalUrl) {
//     if (internalUrl.isNotEmpty && !internalUrl.startsWith('/')) {
//       internalUrl = '/$internalUrl';
//     }
//     return '$_basePath/';
//   }
// }