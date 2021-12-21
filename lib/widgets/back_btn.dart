import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => Navigator.pop(context),
      fillColor: Colors.white,
      child: const Icon(
        CupertinoIcons.back,
        size: 23,
        color: kPurple,
      ),
      shape: const CircleBorder(),
    );
  }
}
