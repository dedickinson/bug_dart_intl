Two small apps for testing locales on Linux.

You can check the locale on your Linux system by running `locale` and `echo $LANG`.

```
LANG="en_AU.UTF-8" dart run bin/default_locale.dart
```

To try the more verbose app, run the following command:

```
dart run bin/bug_dart_intl.dart
```

You can override your default `LANG` with the following command - this one fails:

```
LANG="en_AU.UTF-8" dart run bin/bug_dart_intl.dart
```

You can override your default `LANG` with the following command - this one works:

```
LANG="en_AU" dart run bin/bug_dart_intl.dart
```

---

## Bug details

**Describe the bug**

I'm running on a Linux system and the call to `Locale.parse(Intl.getCurrentLocale())` is throwing a FormatException:

```
FormatException: Locale "en_AU.UTF-8": bad subtag "au.utf".
```

Is it a reasonable expectation that Intl will drop the `.UTF-8` so that `Intl.getCurrentLocale()` only returns the language and the region (`en_AU`)?

**To Reproduce**

My `$LANG` environment variable is `en_AU.UTF-8`.

Calling `locale` yields:

```
LANG=en_AU.UTF-8
LANGUAGE=en_AU:en
LC_CTYPE="en_AU.UTF-8"
LC_NUMERIC="en_AU.UTF-8"
LC_TIME="en_AU.UTF-8"
LC_COLLATE="en_AU.UTF-8"
LC_MONETARY="en_AU.UTF-8"
LC_MESSAGES="en_AU.UTF-8"
LC_PAPER="en_AU.UTF-8"
LC_NAME="en_AU.UTF-8"
LC_ADDRESS="en_AU.UTF-8"
LC_TELEPHONE="en_AU.UTF-8"
LC_MEASUREMENT="en_AU.UTF-8"
LC_IDENTIFICATION="en_AU.UTF-8"
LC_ALL=en_AU.UTF-8
```

Say you have the following code in `bin/default_locale.dart`

```dart
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/locale.dart';

void main() async {
  await findSystemLocale();
  Locale.parse(Intl.getCurrentLocale());
}
```

You can then call:

```
LANG="en_AU.UTF-8" dart run bin/default_locale.dart
```

To replicate the error.

**System info**

```
Dart SDK 3.5.0
Flutter SDK 3.24.0
bug_dart_intl 0.0.1

dependencies:
- args 2.5.0
- intl 0.19.0 [clock meta path]

dev dependencies:
- lints 4.0.0
- test 1.25.8 [analyzer async boolean_selector collection coverage http_multi_server io js matcher node_preamble package_config path pool shelf shelf_packages_handler shelf_static shelf_web_socket source_span stack_trace stream_channel test_api test_core typed_data web_socket_channel webkit_inspection_protocol yaml]

transitive dependencies:
- _fe_analyzer_shared 73.0.0 [meta]
- _macros 0.3.2
- analyzer 6.8.0 [_fe_analyzer_shared collection convert crypto glob macros meta package_config path pub_semver source_span watcher yaml]
- async 2.11.0 [collection meta]
- boolean_selector 2.1.1 [source_span string_scanner]
- clock 1.1.1
- collection 1.19.0
- convert 3.1.1 [typed_data]
- coverage 1.9.2 [args glob logging package_config path source_maps stack_trace vm_service]
- crypto 3.0.5 [typed_data]
- file 7.0.0 [meta path]
- frontend_server_client 4.0.0 [async path]
- glob 2.1.2 [async collection file path string_scanner]
- http_multi_server 3.2.1 [async]
- http_parser 4.1.0 [collection source_span string_scanner typed_data]
- io 1.0.4 [meta path string_scanner]
- js 0.7.1
- logging 1.2.0
- macros 0.1.2-main.4 [_macros]
- matcher 0.12.16+1 [async meta stack_trace term_glyph test_api]
- meta 1.15.0
- mime 1.0.6
- node_preamble 2.0.2
- package_config 2.1.0 [path]
- path 1.9.0
- pool 1.5.1 [async stack_trace]
- pub_semver 2.1.4 [collection meta]
- shelf 1.4.2 [async collection http_parser path stack_trace stream_channel]
- shelf_packages_handler 3.0.2 [path shelf shelf_static]
- shelf_static 1.1.3 [convert http_parser mime path shelf]
- shelf_web_socket 2.0.0 [shelf stream_channel web_socket_channel]
- source_map_stack_trace 2.1.2 [path source_maps stack_trace]
- source_maps 0.10.12 [source_span]
- source_span 1.10.0 [collection path term_glyph]
- stack_trace 1.11.1 [path]
- stream_channel 2.1.2 [async]
- string_scanner 1.3.0 [source_span]
- term_glyph 1.2.1
- test_api 0.7.3 [async boolean_selector collection meta source_span stack_trace stream_channel string_scanner term_glyph]
- test_core 0.6.5 [analyzer args async boolean_selector collection coverage frontend_server_client glob io meta package_config path pool source_map_stack_trace source_maps source_span stack_trace stream_channel test_api vm_service yaml]
- typed_data 1.3.2 [collection]
- vm_service 14.2.5
- watcher 1.1.0 [async path]
- web 1.0.0
- web_socket 0.1.6 [web]
- web_socket_channel 3.0.1 [async crypto stream_channel web web_socket]
- webkit_inspection_protocol 1.2.1 [logging]
- yaml 3.1.2 [collection source_span string_scanner]
```
