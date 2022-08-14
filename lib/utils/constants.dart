// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';

class FxConstantData {
  final double containerRadius;
  final double cardRadius;
  final double buttonRadius;

  FxConstantData(
      {this.containerRadius = 8, this.cardRadius = 8, this.buttonRadius = 8});
}

class FxConstant {
  static FxConstantData constant = FxConstantData();

  static setConstant(FxConstantData constantData) {
    constant = constantData;
  }
}

class Constant {
  static MaterialRadius buttonRadius =
      MaterialRadius(xs: 4, small: 8, medium: 16, large: 24);
  static MaterialRadius textFieldRadius =
      MaterialRadius(xs: 4, small: 8, medium: 16, large: 24);
  static MaterialRadius containerRadius =
      MaterialRadius(xs: 4, small: 8, medium: 16, large: 24);

  static ColorData softColors = ColorData();

  @Deprecated('message')
  static final Color occur = const Color(0xffb38220);
  @Deprecated('message')
  static final Color peach = const Color(0xffe09c5f);
  @Deprecated('message')
  static final Color skyBlue = const Color(0xff639fdc);
  @Deprecated('message')
  static final Color darkGreen = const Color(0xff226e79);
  @Deprecated('message')
  static final Color red = const Color(0xfff8575e);
  @Deprecated('message')
  static final Color purple = const Color(0xff9f50bf);
  @Deprecated('message')
  static final Color pink = const Color(0xffd17b88);
  @Deprecated('message')
  static final Color brown = const Color(0xffbd631a);
  @Deprecated('message')
  static final Color blue = const Color(0xff1a71bd);
  @Deprecated('message')
  static final Color green = const Color(0xff068425);
  @Deprecated('message')
  static final Color yellow = const Color(0xfffff44f);
  @Deprecated('message')
  static final Color orange = const Color(0xffFFA500);
}

class ColorData {
  final Color star = const Color(0xffFFC233);

  final ColorGroup pink =
      ColorGroup(const Color(0xffFFC2D9), const Color(0xffF5005E));
  final ColorGroup violet =
      ColorGroup(const Color(0xffD0BADE), const Color(0xff4E2E60));
  final ColorGroup blue =
      ColorGroup(const Color(0xffADD8FF), const Color(0xff004A8F));
  final ColorGroup green =
      ColorGroup(const Color(0xffAFE9DA), const Color(0xff165041));
  final ColorGroup orange =
      ColorGroup(const Color(0xffFFCEC2), const Color(0xffFF3B0A));

  final List<ColorGroup> list = [];

  ColorData() {
    list.addAll([pink, violet, blue, green, orange]);
  }
}

class ColorGroup {
  final Color color, onColor;

  ColorGroup(this.color, this.onColor);
}

class MaterialRadius {
  late double xs, small, medium, large;

  MaterialRadius(
      {this.xs = 4, this.small = 8, this.medium = 16, this.large = 24});
}
