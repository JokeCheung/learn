import 'package:flutter/material.dart' hide TextField;
import '../material/text_field.dart';

class MyTextField extends TextField {
  MyTextField({
    super.key,
    super.controller,
    super.focusNode,
    super.undoController,
    super.decoration,
    TextInputType? keyboardType,
    super.textInputAction,
    super.textCapitalization,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textAlignVertical,
    super.textDirection,
    super.readOnly,
    @Deprecated(
      'Use `contextMenuBuilder` instead. '
      'super feature was deprecated after v3.3.0-0.5.pre.',
    )
    super.toolbarOptions,
    super.showCursor,
    super.autofocus,
    super.statesController,
    super.obscuringCharacter,
    super.obscureText,
    super.autocorrect,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    super.enableSuggestions,
    super.maxLines,
    super.minLines,
    super.expands,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.onAppPrivateCommand,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorOpacityAnimates,
    super.cursorColor,
    super.cursorErrorColor,
    super.selectionHeightStyle,
    super.selectionWidthStyle,
    super.keyboardAppearance,
    super.scrollPadding,
    super.dragStartBehavior,
    bool? enableInteractiveSelection,
    super.selectionControls,
    super.onTap,
    super.onTapAlwaysCalled,
    super.onTapOutside,
    super.mouseCursor,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.autofillHints,
    super.contentInsertionConfiguration,
    super.clipBehavior,
    super.restorationId,
    super.scribbleEnabled,
    super.enableIMEPersonalizedLearning,
    super.contextMenuBuilder,
    super.canRequestFocus,
    super.spellCheckConfiguration,
    super.magnifierConfiguration,
  });
}

class MyTextFieldState extends TextFieldState {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return super.build(context);
  }
}
