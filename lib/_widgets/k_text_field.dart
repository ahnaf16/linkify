import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:linkify/main.export.dart';

class KTextField extends HookWidget {
  const KTextField({
    Key? key,
    Key? superKey,
    this.name,
    this.title,
    this.hintText,
    this.isRequired = false,
    this.isPassField = false,
    this.initialValue,
    this.validators,
    this.keyboardType,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.fillColor,
    this.prefixIcon,
    this.borderRadius,
    this.textInputAction,
    this.autofocus = false,
    this.outsideSuffix,
    this.isDense = true,
    this.prefixText,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.suffixIcon,
    this.titleStyle,
    this.focusNode,
    this.valueTransformer,
    this.autofillHints,
    this.unfocusOutside = true,
  }) : _key = key,
       super(key: superKey);

  final Key? _key;
  final String? name;
  final String? title;
  final String? hintText;
  final bool isRequired;
  final bool isPassField;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<FormFieldValidator<String>>? validators;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final TextEditingController? controller;
  final int? maxLength;
  final int maxLines;
  final bool readOnly;
  final bool enabled;
  final Function()? onTap;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Icon? prefixIcon;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final Widget? outsideSuffix;
  final bool isDense;
  final String? prefixText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final TextStyle? titleStyle;
  final FocusNode? focusNode;
  final dynamic Function(String? value)? valueTransformer;
  final List<String>? autofillHints;
  final bool unfocusOutside;

  @override
  Widget build(BuildContext context) {
    final rndName = useMemoized(() => randomInt(10, 10000).run().toString(), [key]);
    final hideText = useState<bool>(true);

    final effectiveVPad = isDense ? 10.0 : 15.0;
    final effectiveHPad = prefixText != null ? 10.0 : (isDense ? 10.0 : 20.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: titleStyle ?? context.text.titleSmall?.medium).required(isRequired),
        if (title != null) const Gap(Insets.sm),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                key: _key,
                name: name ?? rndName,
                autofocus: autofocus,
                obscureText: isPassField ? hideText.value : false,
                initialValue: initialValue,
                controller: controller,
                inputFormatters: inputFormatters,
                keyboardType: (isPassField && !hideText.value) ? TextInputType.visiblePassword : keyboardType,
                textInputAction: textInputAction,
                autofillHints: autofillHints,
                maxLines: maxLines,
                maxLength: maxLength,
                readOnly: readOnly,
                focusNode: focusNode,
                enabled: enabled,
                onTap: onTap,
                onChanged: (v) => onChanged?.call(v ?? ''),
                onSubmitted: (v) => onSubmitted?.call(v ?? ''),
                valueTransformer: (value) {
                  valueTransformer?.call(value);
                  return name == null ? '' : value;
                },
                onTapOutside: (_) => unfocusOutside ? InputUtils.unFocus() : null,
                validator: FormBuilderValidators.compose([
                  if (isRequired) FormBuilderValidators.required(),
                  ...?validators,
                ]),
                textAlign: textAlign,
                decoration: InputDecoration(
                  isDense: isDense,
                  contentPadding: Pads.sym(effectiveHPad, effectiveVPad),
                  hintText: hintText,
                  hintStyle: context.text.bodyLarge!.op(.5),
                  filled: true,
                  fillColor: fillColor,
                  prefixIcon: prefixIcon,
                  prefixText: prefixText,
                  prefixStyle: context.text.bodyMedium!.op(.5),
                  alignLabelWithHint: true,
                  suffixIcon: !isPassField
                      ? (suffixIcon)
                      : GestureDetector(
                          onTap: () => hideText.value = !hideText.value,
                          child: DecoContainer(
                            // color: Colors.red,
                            constraints: const BoxConstraints.tightFor(width: 20, height: 20),
                            alignment: Alignment.centerRight,
                            child: Center(
                              child: hideText.value
                                  ? const Icon(Icons.visibility_off_rounded)
                                  : const Icon(Icons.visibility_rounded),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            if (outsideSuffix != null) const Gap(Insets.sm),
            if (outsideSuffix != null) outsideSuffix!,
          ],
        ),
      ],
    );
  }
}
