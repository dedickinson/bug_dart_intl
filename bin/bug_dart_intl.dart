/*
 Copyright 2024 Duncan Dickinson

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import 'dart:io';

import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:intl/locale.dart';

void main() async {
  print('Platform: isLinux: ${Platform.isLinux}');
  print('Platform: localeName: ${Platform.localeName}');

  print('---');
  final envLang = Platform.environment['LANG'];
  print('Environment: LANG: $envLang');

  print('---');
  final locale = await findSystemLocale();
  print('System locale: $locale');
  print('Canonicalized locale: ${Intl.canonicalizedLocale(locale)}');

  print('Default locale: ${Intl.defaultLocale}');
  print('System locale: ${Intl.systemLocale}');

  print('Current Locale: ${Intl.getCurrentLocale()}');

  try {
    final parsedLocale = Locale.parse(Intl.getCurrentLocale());
    print('Parsed Locale: $parsedLocale');
  } on FormatException catch (e) {
    print('Trying to parse locale ($locale) failed with $e');
  }
}
