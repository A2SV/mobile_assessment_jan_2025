import 'package:flutter/material.dart';
import 'package:mobile_assessment_jan_2025/widgets/small_icon_widget.dart';

import '../app/common/ui_helpers.dart';

class CartCalculatorWidget extends StatelessWidget {
  const CartCalculatorWidget(
      {super.key, required this.onAdd, required this.onSubstact});
  final VoidCallback onAdd;
  final VoidCallback onSubstact;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmallIconWidget(
          name: ' - ',
          selected: true,
          onTap: () => onSubstact(),
          roundness: 1,
          vPadding: tinySize,
          hPadding: middleSize,
        ),
        // horizontalSpaceSmall,
        // InputField(
        //   controller: viewModel.controller,
        //   width: 60, //todo would be good if this is dynamic
        //   height: 40,
        //   charLength: 3,
        //   onchange: (value) => onChange(value),
        //   centerText: true,
        //   hint: '1',
        //   inputFormatter: [
        //     FilteringTextInputFormatter.allow(RegExp(r'[1-9]')),
        //   ],
        // ),
        horizontalSpaceSmall,
        SmallIconWidget(
          name: ' + ',
          selected: true,
          onTap: () => onAdd(),
          roundness: 1,
          vPadding: tinySize,
          hPadding: middleSize,
        )
      ],
    );
  }
}
