import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextEx on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  showSnackBar(SnackBar snackBar) =>
      ScaffoldMessenger.of(this).showSnackBar(snackBar);

  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
