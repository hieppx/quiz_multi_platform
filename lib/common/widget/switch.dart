import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_multi_platform/common/theme.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        }
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
        MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return null;
      },
    );

    return Switch(
      value: light,
      overlayColor: overlayColor,
      trackColor: trackColor,
      thumbColor: MaterialStateProperty.all<Color>(const Color(0xFF6192F5)),
      onChanged: (bool value) {
        Provider.of<ThemeProvider>(context, listen: false).toggleMode();
        setState(() {
          light = value;
        });
      },
    );
  }
}


