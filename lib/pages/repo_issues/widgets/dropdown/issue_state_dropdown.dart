import 'package:flutter/material.dart';
import 'package:git_explorer/core/theme/theme_extension.dart';
import 'package:git_explorer/pages/repo_issues/models/repo_issue_type/repo_issue_type.dart';

class IssueStateDropdown extends StatefulWidget {
  const IssueStateDropdown({
    required this.onChanged,
    this.initialStateType = IssueStateType.open,
    super.key,
  });

  final void Function(IssueStateType) onChanged;
  final IssueStateType initialStateType;

  @override
  State<IssueStateDropdown> createState() => _IssueStateDropdownState();
}

class _IssueStateDropdownState extends State<IssueStateDropdown> {
  late IssueStateType _selectedState;

  @override
  void initState() {
    super.initState();
    _selectedState = widget.initialStateType;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<IssueStateType>(
      value: _selectedState,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      underline: Container(height: 2),
      onChanged: (IssueStateType? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedState = newValue;
          });
          widget.onChanged(newValue);
        }
      },
      isDense: true,
      borderRadius: BorderRadius.circular(8),
      items:
          IssueStateType.values.map<DropdownMenuItem<IssueStateType>>((
            IssueStateType type,
          ) {
            return DropdownMenuItem<IssueStateType>(
              value: type,

              child: Text(type.value, style: context.textTheme.bodyLarge),
            );
          }).toList(),
    );
  }
}
