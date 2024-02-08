import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_mask/easy_mask.dart';

class InputHelper {
  static MaskTextInputFormatter maskTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "# (###) ###-##-##",
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
  }

  static MaskTextInputFormatter bankTextInputFormatter() {
    return MaskTextInputFormatter(
      mask: "####  ####  ####  ####",
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
  }

  static TextInputMask dateTextInputFormatter() {
    return TextInputMask(mask: '99.99.9999');

// ExampleMask(
//       formatter: MaskTextInputFormatter(mask: "##/##/####"),
//       hint: "31/12/2020",
//       textInputType: TextInputType.phone,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return null;
//         }
//         final components = value.split("/");
//         if (components.length == 3) {
//           final day = int.tryParse(components[0]);
//           final month = int.tryParse(components[1]);
//           final year = int.tryParse(components[2]);
//           if (day != null && month != null && year != null) {
//             final date = DateTime(year, month, day);
//             if (date.year == year && date.month == month && date.day == day) {
//               return null;
//             }
//           }
//         }
//         return "wrong date";
//       }
//     ),
  }

  static MaskTextInputFormatter creditCardDateInputFormatter() {
    return MaskTextInputFormatter(
      mask: "##/## ",
      filter: {
        "#": RegExp(r'[0-9]'),
      },
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
