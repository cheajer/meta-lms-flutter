import 'package:flutter/material.dart';

class PoweredByWidget extends StatelessWidget {
  final String poweredByText;
  final TextStyle? textStyle;

  const PoweredByWidget({
    Key? key,
    this.poweredByText = 'Powered by MetaLMS',
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
          top: 16.0, bottom: 16.0), // Adjust the padding as needed
      alignment: Alignment.center,
      child: Text(
        poweredByText,
        style: textStyle ??
            Theme.of(context).textTheme.caption?.copyWith(
                color:
                    Colors.grey), // Provide a default style if none is provided
      ),
    );
  }
}
