import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class GenderSelector extends StatefulWidget {
  final TextEditingController controller;
  final bool isEnabled;

  const GenderSelector({
    super.key,
    required this.controller,
    this.isEnabled = true,
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String _selectedGender; // Tracks the current gender

  @override
  void initState() {
    super.initState();
    // Set initial gender and attach listener to controller
    _selectedGender = widget.controller.text.isNotEmpty
        ? widget.controller.text
        : "F"; // Default to Female if empty
    widget.controller.text = _selectedGender;

    // Add listener to respond to controller changes
    widget.controller.addListener(_updateGenderFromController);
  }

  @override
  void dispose() {
    // Clean up the listener
    widget.controller.removeListener(_updateGenderFromController);
    super.dispose();
  }

  // Update the local state if controller value changes
  void _updateGenderFromController() {
    if (widget.controller.text != _selectedGender) {
      setState(() {
        _selectedGender = widget.controller.text;
      });
    }
  }

  void _onGenderChanged(String gender) {
    setState(() {
      _selectedGender = gender;
      widget.controller.text = gender; // Update the controller value
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isEnabled)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _genderIconButton("M", Ionicons.male),
              const SizedBox(width: 20),
              _genderIconButton("F", Ionicons.female),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _genderIconButton(_selectedGender,
                  (_selectedGender == "M") ? Ionicons.male : Ionicons.female),
              const SizedBox(width: 20),
            ],
          );
  }

  // Gender IconButton Widget
  Widget _genderIconButton(String value, IconData icon) {
    return IconButton(
      enableFeedback: widget.isEnabled,
      icon: Icon(
        icon,
        color: _selectedGender == value ? Colors.white : Colors.black,
        size: 22,
      ),
      style: IconButton.styleFrom(
        backgroundColor:
            _selectedGender == value ? Colors.deepPurple : Colors.grey.shade200,
        fixedSize: const Size(50, 50),
      ),
      onPressed: () {
        if (widget.isEnabled) {
          _onGenderChanged(value);
        }
      },
    );
  }
}
