// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

// Navigation shortcuts to move the selected menu items up or down.
Map<ShortcutActivator, Intent> _kMenuTraversalShortcuts =
    <ShortcutActivator, Intent>{
  LogicalKeySet(LogicalKeyboardKey.arrowUp): const _ArrowUpIntent(),
  LogicalKeySet(LogicalKeyboardKey.arrowDown): const _ArrowDownIntent(),
};

const double _kMinimumWidth = 112.0;

const double _kDefaultHorizontalPadding = 12.0;

class DropdownEntry<T> {
  const DropdownEntry({
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.style,
  });

  /// the value used to identify the entry.
  ///
  /// This value must be unique across all entries in a [DropdownSearchable].
  final T value;

  /// The label displayed in the center of the menu item.
  final String label;

  /// An optional icon to display before the label.
  final Widget? leadingIcon;

  /// An optional icon to display after the label.
  final Widget? trailingIcon;

  /// Whether the menu item is enabled or disabled.
  ///
  /// The default value is true. If true, the [DropdownEntry.label] will be filled
  /// out in the text field of the [DropdownSearchable] when this entry is clicked; otherwise,
  /// this entry is disabled.
  final bool enabled;

  /// Customizes this menu item's appearance.
  ///
  /// Null by default.
  final ButtonStyle? style;
}

class DropdownSearchable<T> extends StatefulWidget {
  /// Creates a const [DropdownSearchable].
  ///
  /// The leading and trailing icons in the text field can be customized by using
  /// [leadingIcon], [trailingIcon] and [selectedTrailingIcon] properties. They are
  /// passed down to the [InputDecoration] properties, and will override values
  /// in the [InputDecoration.prefixIcon] and [InputDecoration.suffixIcon].
  ///
  /// Except leading and trailing icons, the text field can be configured by the
  /// [InputDecorationTheme] property. The menu can be configured by the [menuStyle].
  const DropdownSearchable({
    super.key,
    this.enabled = true,
    // this.width,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.selectedTrailingIcon,
    // this.enableFilter = false,
    // this.enableSearch = true,
    this.textStyle,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    required this.dropdownMenuEntries,
  });

  final bool enabled;
  // final double? width;
  final double? menuHeight;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? label;
  final String? hintText;
  final Widget? selectedTrailingIcon;
  // final bool enableFilter;
  // final bool enableSearch;
  final TextStyle? textStyle;
  final InputDecorationTheme? inputDecorationTheme;
  final MenuStyle? menuStyle;
  final TextEditingController? controller;
  final T? initialSelection;
  final ValueChanged<T?>? onSelected;
  final List<DropdownEntry<T>> dropdownMenuEntries;

  @override
  State<DropdownSearchable<T>> createState() => _DropdownSearchableState<T>();
}

class _DropdownSearchableState<T> extends State<DropdownSearchable<T>> {
  final GlobalKey _anchorKey = GlobalKey();
  final GlobalKey _leadingKey = GlobalKey();
  final FocusNode _textFocusNode = FocusNode();
  final MenuController _controller = MenuController();
  late final TextEditingController _textEditingController;
  // late bool _enableFilter;
  late List<DropdownEntry<T>> filteredEntries;
  List<Widget>? _initialMenu;
  int? currentHighlight;
  double? leadingPadding;
  bool _menuHasEnabledItem = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    // _enableFilter = widget.enableFilter;
    filteredEntries = widget.dropdownMenuEntries;
    _menuHasEnabledItem =
        filteredEntries.any((DropdownEntry<T> entry) => entry.enabled);

    final int index = filteredEntries.indexWhere(
        (DropdownEntry<T> entry) => entry.value == widget.initialSelection);
    if (index != -1) {
      _textEditingController.text = filteredEntries[index].label;
      _textEditingController.selection =
          TextSelection.collapsed(offset: _textEditingController.text.length);
    }
    refreshLeadingPadding();
  }

  @override
  void didUpdateWidget(DropdownSearchable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dropdownMenuEntries != widget.dropdownMenuEntries) {
      _menuHasEnabledItem =
          filteredEntries.any((DropdownEntry<T> entry) => entry.enabled);
    }
    if (oldWidget.leadingIcon != widget.leadingIcon) {
      refreshLeadingPadding();
    }
    if (oldWidget.initialSelection != widget.initialSelection) {
      final int index = filteredEntries.indexWhere(
          (DropdownEntry<T> entry) => entry.value == widget.initialSelection);
      if (index != -1) {
        _textEditingController.text = filteredEntries[index].label;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      }
    }
  }

  void refreshLeadingPadding() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        leadingPadding = getWidth(_leadingKey);
      });
    });
  }

  double? getWidth(GlobalKey key) {
    final BuildContext? context = key.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject()! as RenderBox;
      return box.size.width;
    }
    return null;
  }

  List<DropdownEntry<T>> filter(List<DropdownEntry<T>> entries,
      TextEditingController textEditingController) {
    final String filterText = textEditingController.text.toLowerCase();
    return entries
        .where((DropdownEntry<T> entry) =>
            entry.label.toLowerCase().contains(filterText))
        .toList();
  }

  int? search(List<DropdownEntry<T>> entries,
      TextEditingController textEditingController) {
    final String searchText = textEditingController.value.text.toLowerCase();
    if (searchText.isEmpty) {
      return null;
    }
    final int index = entries.indexWhere((DropdownEntry<T> entry) =>
        entry.label.toLowerCase().contains(searchText));

    return index != -1 ? index : null;
  }

  List<Widget> _buildButtons(List<DropdownEntry<T>> filteredEntries,
      TextEditingController textEditingController, TextDirection textDirection,
      {int? focusedIndex}) {
    final List<Widget> result = <Widget>[];
    final double padding = leadingPadding ?? _kDefaultHorizontalPadding;
    final ButtonStyle defaultStyle;
    switch (textDirection) {
      case TextDirection.rtl:
        defaultStyle = MenuItemButton.styleFrom(
          padding:
              EdgeInsets.only(left: _kDefaultHorizontalPadding, right: padding),
        );
        break;
      case TextDirection.ltr:
        defaultStyle = MenuItemButton.styleFrom(
          padding:
              EdgeInsets.only(left: padding, right: _kDefaultHorizontalPadding),
        );
        break;
    }

    for (int i = 0; i < filteredEntries.length; i++) {
      final DropdownEntry<T> entry = filteredEntries[i];
      ButtonStyle effectiveStyle = entry.style ?? defaultStyle;
      final Color focusedBackgroundColor = effectiveStyle.foregroundColor
              ?.resolve(<MaterialState>{MaterialState.focused}) ??
          Theme.of(context).colorScheme.onSurface;

      // Simulate the focused state because the text field should always be focused
      // during traversal. If the menu item has a custom foreground color, the "focused"
      // color will also change to foregroundColor.withOpacity(0.12).
      effectiveStyle = entry.enabled && i == focusedIndex
          ? effectiveStyle.copyWith(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  focusedBackgroundColor.withOpacity(0.12)))
          : effectiveStyle;

      final MenuItemButton menuItemButton = MenuItemButton(
        style: effectiveStyle,
        leadingIcon: entry.leadingIcon,
        trailingIcon: entry.trailingIcon,
        onPressed: entry.enabled
            ? () {
                textEditingController.text = entry.label;
                textEditingController.selection = TextSelection.collapsed(
                    offset: textEditingController.text.length);
                // currentHighlight = widget.enableSearch ? i : null;
                widget.onSelected?.call(entry.value);
              }
            : null,
        requestFocusOnHover: false,
        child: Text(entry.label),
      );
      result.add(menuItemButton);
    }

    return result;
  }

  void handleUpKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        // _enableFilter = false;
        currentHighlight ??= 0;
        currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! - 1) % filteredEntries.length;
        }
        final String currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void handleDownKeyInvoke(_) => setState(() {
        if (!_menuHasEnabledItem || !_controller.isOpen) {
          return;
        }
        // _enableFilter = false;
        currentHighlight ??= -1;
        currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        while (!filteredEntries[currentHighlight!].enabled) {
          currentHighlight = (currentHighlight! + 1) % filteredEntries.length;
        }
        final String currentLabel = filteredEntries[currentHighlight!].label;
        _textEditingController.text = currentLabel;
        _textEditingController.selection =
            TextSelection.collapsed(offset: _textEditingController.text.length);
      });

  void handlePressed(MenuController controller) {
    if (controller.isOpen) {
      currentHighlight = null;
      controller.close();
    } else {
      // close to open
      if (_textEditingController.text.isNotEmpty) {
        // _enableFilter = false;
      }
      controller.open();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    _initialMenu ??= _buildButtons(
        widget.dropdownMenuEntries, _textEditingController, textDirection);
    final DropdownMenuThemeData theme = DropdownMenuTheme.of(context);
    final DropdownMenuThemeData defaults = _DropdownMenuDefaultsM3(context);

    // if (_enableFilter) {
    //   filteredEntries =
    //       filter(widget.dropdownMenuEntries, _textEditingController);
    // }

    // if (widget.enableSearch) {
    currentHighlight = search(filteredEntries, _textEditingController);
    // }

    final List<Widget> menu = _buildButtons(
        filteredEntries, _textEditingController, textDirection,
        focusedIndex: currentHighlight);

    final TextStyle? effectiveTextStyle =
        widget.textStyle ?? theme.textStyle ?? defaults.textStyle;

    MenuStyle? effectiveMenuStyle =
        widget.menuStyle ?? theme.menuStyle ?? defaults.menuStyle!;

    final double? anchorWidth = getWidth(_anchorKey);
    // if (widget.width != null) {
    //   effectiveMenuStyle = effectiveMenuStyle.copyWith(
    //       minimumSize:
    //           MaterialStatePropertyAll<Size?>(Size(widget.width!, 0.0)));
    // } else
    if (anchorWidth != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
          minimumSize: MaterialStatePropertyAll<Size?>(Size(anchorWidth, 0.0)));
    }

    if (widget.menuHeight != null) {
      effectiveMenuStyle = effectiveMenuStyle.copyWith(
          maximumSize: MaterialStatePropertyAll<Size>(
              Size(double.infinity, widget.menuHeight!)));
    }
    final InputDecorationTheme effectiveInputDecorationTheme =
        widget.inputDecorationTheme ??
            theme.inputDecorationTheme ??
            defaults.inputDecorationTheme!;

    return Shortcuts(
      shortcuts: _kMenuTraversalShortcuts,
      child: Actions(
        actions: <Type, Action<Intent>>{
          _ArrowUpIntent: CallbackAction<_ArrowUpIntent>(
            onInvoke: handleUpKeyInvoke,
          ),
          _ArrowDownIntent: CallbackAction<_ArrowDownIntent>(
            onInvoke: handleDownKeyInvoke,
          ),
        },
        child: MenuAnchor(
          style: effectiveMenuStyle,
          controller: _controller,
          menuChildren: menu,
          crossAxisUnconstrained: false,
          onClose: () {
            setState(() {});
          }, // To update the status of the IconButton
          builder:
              (BuildContext context, MenuController controller, Widget? child) {
            assert(_initialMenu != null);
            final Widget trailingButton = Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                isSelected: controller.isOpen,
                icon: widget.trailingIcon ?? const Icon(Icons.arrow_drop_down),
                selectedIcon: widget.selectedTrailingIcon ??
                    const Icon(Icons.arrow_drop_up),
                onPressed: () {
                  _textFocusNode.requestFocus();
                  handlePressed(controller);
                },
              ),
            );

            final Widget leadingButton = Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.leadingIcon ?? const SizedBox());

            return _DropdownMenuBody(
              key: _anchorKey,
              // width: widget.width,
              children: <Widget>[
                TextField(
                    focusNode: _textFocusNode,
                    style: effectiveTextStyle,
                    controller: _textEditingController,
                    onEditingComplete: () {
                      if (currentHighlight != null) {
                        final DropdownEntry<T> entry =
                            filteredEntries[currentHighlight!];
                        if (entry.enabled) {
                          _textEditingController.text = entry.label;
                          _textEditingController.selection =
                              TextSelection.collapsed(
                                  offset: _textEditingController.text.length);
                          widget.onSelected?.call(entry.value);
                        }
                      } else {
                        widget.onSelected?.call(null);
                      }
                      // if (!widget.enableSearch) {
                      //   currentHighlight = null;
                      // }
                      if (_textEditingController.text.isNotEmpty) {
                        controller.close();
                      }
                    },
                    onTap: () {
                      handlePressed(controller);
                    },
                    onChanged: (String text) {
                      controller.open();
                      setState(() {
                        filteredEntries = widget.dropdownMenuEntries;
                        // _enableFilter = widget.enableFilter;
                      });
                    },
                    decoration: InputDecoration(
                      enabled: widget.enabled,
                      label: widget.label,
                      hintText: widget.hintText,
                      prefixIcon: widget.leadingIcon != null
                          ? Container(
                              key: _leadingKey, child: widget.leadingIcon)
                          : null,
                      suffixIcon: trailingButton,
                    ).applyDefaults(effectiveInputDecorationTheme)),
                for (Widget c in _initialMenu!) c,
                trailingButton,
                leadingButton,
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ArrowUpIntent extends Intent {
  const _ArrowUpIntent();
}

class _ArrowDownIntent extends Intent {
  const _ArrowDownIntent();
}

class _DropdownMenuBody extends MultiChildRenderObjectWidget {
  _DropdownMenuBody({
    super.key,
    super.children,
  });

  @override
  _RenderDropdownMenuBody createRenderObject(BuildContext context) {
    return _RenderDropdownMenuBody();
  }
}

class _DropdownMenuBodyParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderDropdownMenuBody extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _DropdownMenuBodyParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox,
            _DropdownMenuBodyParentData> {
  _RenderDropdownMenuBody();

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _DropdownMenuBodyParentData) {
      child.parentData = _DropdownMenuBodyParentData();
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    double maxWidth = 0.0;
    double? maxHeight;
    RenderBox? child = firstChild;

    final BoxConstraints innerConstraints = BoxConstraints(
      maxWidth: constraints.maxWidth ??
          computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );
    while (child != null) {
      if (child == firstChild) {
        child.layout(innerConstraints, parentUsesSize: true);
        maxHeight ??= child.size.height;
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      child.layout(innerConstraints, parentUsesSize: true);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, child.size.width);
      maxHeight ??= child.size.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    size = constraints.constrain(Size(maxWidth, maxHeight!));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final RenderBox? child = firstChild;
    if (child != null) {
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      context.paintChild(child, offset + childParentData.offset);
    }
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final BoxConstraints constraints = this.constraints;
    double maxWidth = 0.0;
    double? maxHeight;
    RenderBox? child = firstChild;
    final BoxConstraints innerConstraints = BoxConstraints(
      maxWidth: computeMaxIntrinsicWidth(constraints.maxWidth),
      maxHeight: computeMaxIntrinsicHeight(constraints.maxHeight),
    );

    while (child != null) {
      if (child == firstChild) {
        final Size childSize = child.getDryLayout(innerConstraints);
        maxHeight ??= childSize.height;
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        assert(child.parentData == childParentData);
        child = childParentData.nextSibling;
        continue;
      }
      final Size childSize = child.getDryLayout(innerConstraints);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      childParentData.offset = Offset.zero;
      maxWidth = math.max(maxWidth, childSize.width);
      maxHeight ??= childSize.height;
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    assert(maxHeight != null);
    maxWidth = math.max(_kMinimumWidth, maxWidth);
    return constraints.constrain(Size(maxWidth, maxHeight!));
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double width = 0;
    while (child != null) {
      if (child == firstChild) {
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final double maxIntrinsicWidth = child.getMinIntrinsicWidth(height);
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    RenderBox? child = firstChild;
    double width = 0;
    while (child != null) {
      if (child == firstChild) {
        final _DropdownMenuBodyParentData childParentData =
            child.parentData! as _DropdownMenuBodyParentData;
        child = childParentData.nextSibling;
        continue;
      }
      final double maxIntrinsicWidth = child.getMaxIntrinsicWidth(height);
      // Add the width of leading Icon.
      if (child == lastChild) {
        width += maxIntrinsicWidth;
      }
      // Add the width of trailing Icon.
      if (child == childBefore(lastChild!)) {
        width += maxIntrinsicWidth;
      }
      width = math.max(width, maxIntrinsicWidth);
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      child = childParentData.nextSibling;
    }

    return math.max(width, _kMinimumWidth);
  }

  @override
  double computeMinIntrinsicHeight(double height) {
    final RenderBox? child = firstChild;
    double width = 0;
    if (child != null) {
      width = math.max(width, child.getMinIntrinsicHeight(height));
    }
    return width;
  }

  @override
  double computeMaxIntrinsicHeight(double height) {
    final RenderBox? child = firstChild;
    double width = 0;
    if (child != null) {
      width = math.max(width, child.getMaxIntrinsicHeight(height));
    }
    return width;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = firstChild;
    if (child != null) {
      final _DropdownMenuBodyParentData childParentData =
          child.parentData! as _DropdownMenuBodyParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}

// Hand coded defaults. These will be updated once we have tokens/spec.
class _DropdownMenuDefaultsM3 extends DropdownMenuThemeData {
  _DropdownMenuDefaultsM3(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);

  @override
  TextStyle? get textStyle => _theme.textTheme.labelLarge;

  @override
  MenuStyle get menuStyle {
    return const MenuStyle(
      minimumSize: MaterialStatePropertyAll<Size>(Size(_kMinimumWidth, 0.0)),
      maximumSize: MaterialStatePropertyAll<Size>(Size.infinite),
    );
  }

  @override
  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(border: OutlineInputBorder());
  }
}
