import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:principle_fe/app/ui/components/dropdowns/dropdown_searchable.dart';

class DropdownSearchableFormField<T> extends FormField<T> {
  DropdownSearchableFormField({
    super.key,
    FormFieldSetter<T>? onSaved,
    FormFieldValidator<T>? validator,
    T? initialValue,
    AutovalidateMode? autovalidateMode,
    TextEditingController? controller,
    required List<DropdownEntry<T>> dropdownMenuEntries,
    Widget? label,
    Widget? leadingIcon,
    double? menuHeight,
    InputDecoration? decoration = const InputDecoration(),
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<T> state) {
              // final InputDecoration effectiveDecoration = (decoration ??
              //         const InputDecoration())
              //     .applyDefaults(Theme.of(state.context).inputDecorationTheme);
              final effectiveDecorationTheme =
                  Theme.of(state.context).inputDecorationTheme;

              return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownSearchable<T>(
                      // initialSelection: ColorLabel.green,
                      controller: controller,
                      label: label,
                      leadingIcon: leadingIcon,
                      dropdownMenuEntries: dropdownMenuEntries,
                      menuHeight: menuHeight,
                      onSelected: (T? val) {
                        state.didChange(val);
                      },
                      errorText: state.errorText,
                      // inputDecorationTheme: effectiveDecorationTheme,
                      // decoration: effectiveDecoration.copyWith(errorText: field.errorText),
                    ),
                  ]);
              // return DropdownSearchable<T>(
              //   // initialSelection: ColorLabel.green,
              //   controller: controller,
              //   label: label,
              //   leadingIcon: leadingIcon,
              //   dropdownMenuEntries: dropdownMenuEntries,
              //   menuHeight: menuHeight,
              //   onSelected: (T? val) {
              //     state.didChange(val);
              //   },
              // );
            });
}
