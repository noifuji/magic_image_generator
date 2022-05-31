import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:magic_image_generator/viewmodel/app_settings_view_model.dart';
import 'package:provider/provider.dart';

class LanguageDropDownList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(children:[
      const Icon(Icons.language),
      DropdownButton<String>(
      value: Provider.of<AppSettingsViewModel>(context).getLanguageCode(),
      elevation: 16,
      //style: TextStyle(color: Theme.of(context).colorScheme.primary),
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.secondary.withAlpha(50),
      ),
      onChanged: (String? newValue) {
        if(newValue == null) {
          return;
        }
        Provider.of<AppSettingsViewModel>(context, listen: false).saveLanguageCode(newValue);
      },
      items: AppLocalizations.supportedLocales
          .map<DropdownMenuItem<String>>((Locale value) {
            String languageName = "";
            if(value.languageCode == "ja") {
              languageName = AppLocalizations.of(context)!.japanese;
            } else if(value.languageCode == "en") {
              languageName = AppLocalizations.of(context)!.english;
            }

        return DropdownMenuItem<String>(
          value: value.languageCode,
          child: Text(languageName, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    )]);
  }
}
