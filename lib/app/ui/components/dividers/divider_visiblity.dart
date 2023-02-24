import 'package:flutter/material.dart';

class DividerVisiblity extends StatelessWidget {
  /// Creates a Material Design divider.
  ///
  /// The [height], [thickness], [indent], and [endIndent] must be null or
  /// non-negative.
  const DividerVisiblity({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
    this.isVisible,
  })  : assert(height == null || height >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0);

  final bool? isVisible;

  /// The divider's height extent.
  ///
  /// The divider itself is always drawn as a horizontal line that is centered
  /// within the height specified by this value.
  ///
  /// If this is null, then the [DividerThemeData.space] is used. If that is
  /// also null, then this defaults to 16.0.
  final double? height;

  /// The thickness of the line drawn within the divider.
  ///
  /// A divider with a [thickness] of 0.0 is always drawn as a line with a
  /// height of exactly one device pixel.
  ///
  /// If this is null, then the [DividerThemeData.thickness] is used. If
  /// that is also null, then this defaults to 0.0.
  final double? thickness;

  /// The amount of empty space to the leading edge of the divider.
  ///
  /// If this is null, then the [DividerThemeData.indent] is used. If that is
  /// also null, then this defaults to 0.0.
  final double? indent;

  /// The amount of empty space to the trailing edge of the divider.
  ///
  /// If this is null, then the [DividerThemeData.endIndent] is used. If that is
  /// also null, then this defaults to 0.0.
  final double? endIndent;

  /// The color to use when painting the line.
  ///
  /// If this is null, then the [DividerThemeData.color] is used. If that is
  /// also null, then [ThemeData.dividerColor] is used.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// const Divider(
  ///   color: Colors.deepOrange,
  /// )
  /// ```
  /// {@end-tool}
  final Color? color;

  BorderSide createBorderSide(BuildContext? context,
      {Color? color, double? width}) {
    final DividerThemeData? dividerTheme =
        context != null ? DividerTheme.of(context) : null;
    final DividerThemeData? defaults = context != null
        ? Theme.of(context).useMaterial3
            ? _DividerDefaultsM3(context)
            : _DividerDefaultsM2(context)
        : null;
    final Color? effectiveColor =
        color ?? dividerTheme?.color ?? defaults?.color;
    final double effectiveWidth =
        width ?? dividerTheme?.thickness ?? defaults?.thickness ?? 0.0;

    // Prevent assertion since it is possible that context is null and no color
    // is specified.
    if (effectiveColor == null) {
      return BorderSide(
        width: effectiveWidth,
      );
    }
    return BorderSide(
      color: effectiveColor,
      width: effectiveWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final DividerThemeData defaults = theme.useMaterial3
        ? _DividerDefaultsM3(context)
        : _DividerDefaultsM2(context);
    final double height = this.height ?? dividerTheme.space ?? defaults.space!;
    final double thickness =
        this.thickness ?? dividerTheme.thickness ?? defaults.thickness!;
    final double indent =
        this.indent ?? dividerTheme.indent ?? defaults.indent!;
    final double endIndent =
        this.endIndent ?? dividerTheme.endIndent ?? defaults.endIndent!;

    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(start: indent, end: endIndent),
          decoration: isVisible == false
              ? null
              : BoxDecoration(
                  border: Border(
                    bottom: createBorderSide(context,
                        color: color, width: thickness),
                  ),
                ),
        ),
      ),
    );
  }
}

class _DividerDefaultsM2 extends DividerThemeData {
  const _DividerDefaultsM2(this.context)
      : super(
          space: 16,
          thickness: 0,
          indent: 0,
          endIndent: 0,
        );

  final BuildContext context;

  @override
  Color? get color => Theme.of(context).dividerColor;
}

class _DividerDefaultsM3 extends DividerThemeData {
  const _DividerDefaultsM3(this.context)
      : super(
          space: 16,
          thickness: 1.0,
          indent: 0,
          endIndent: 0,
        );

  final BuildContext context;

  @override
  Color? get color => Theme.of(context).colorScheme.outlineVariant;
}
