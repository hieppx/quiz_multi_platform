import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  List<String> list = <String>['VI', 'EN'];
  String? dropdownValue = 'VI';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      dropdownValue = prefs.getString('value') ?? 'VI';
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.language,
        size: 22,
      ),
      elevation: 16,
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (String? value) async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('value', value!);
        setState(() {
          dropdownValue = prefs.getString('value')!;
          context
              .read<ThemeProvider>()
              .changeLocale(dropdownValue!.toLowerCase());
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
