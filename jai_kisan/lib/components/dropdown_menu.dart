import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String label;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdownButton({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
        const SizedBox(width: 15.0),
        Expanded(
          flex: 2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: widget.selectedValue,
            onChanged: widget.onChanged,
            items: widget.options
                .map<DropdownMenuItem<String>>(
                  (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}