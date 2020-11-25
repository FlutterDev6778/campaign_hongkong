library keicy_dropdown_form_field;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeicyDropDownFormField extends FormField<dynamic> {
  KeicyDropDownFormField({
    Key key,
    @required double width,
    @required double height,
    @required List<Map<String, dynamic>> menuItems,
    Function(dynamic) onChangeHandler,
    bool isDense: true,
    bool isExpanded: true,
    dynamic value,
    bool autovalidate: false,
    FormFieldValidator<dynamic> onValidateHandler,
    Function onSaveHandler,

    /// label
    String label = "",
    double labelSpacing = 5,
    TextStyle labelStyle,

    /// icons
    double iconSpacing = 10,
    double iconSize = 20,

    /// border
    Color fillColor = Colors.transparent,
    Border border = const Border(bottom: BorderSide(width: 1, color: Colors.black)),
    Border errorBorder = const Border(bottom: BorderSide(width: 1, color: Colors.red)),
    double borderRadius = 0,
    // textfield
    double contentHorizontalPadding = 5,
    double contentVerticalPadding = 5,
    TextStyle itemStyle,
    TextStyle selectedItemStyle = const TextStyle(fontSize: 15, color: Colors.black),
    Color dropdownColor = Colors.white,
    String hintText = "",
    TextStyle hintStyle = const TextStyle(fontSize: 15, color: Colors.grey),
    bool fixedHeightState = true,
    bool isDoneValidate = false,
    FocusNode focusNode,
    Color iconEnabledColor,
    Color iconDisabledColor,
  }) : super(
          key: key,
          initialValue: value,
          autovalidate: autovalidate,
          validator: (value) {
            isDoneValidate = true;
            if (onValidateHandler != null) return onValidateHandler(value);
            return null;
          },
          onSaved: onSaveHandler,
          builder: (FormFieldState<dynamic> state) {
            itemStyle = itemStyle ?? selectedItemStyle;
            labelStyle = labelStyle ?? selectedItemStyle;

            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => KeicyDropDownFormFieldProvider(value)),
              ],
              child: Consumer<KeicyDropDownFormFieldProvider>(
                builder: (context, customDropDownFormFieldProvider, _) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                    if (customDropDownFormFieldProvider.isDoneValidate != isDoneValidate) customDropDownFormFieldProvider.setIsDoneValidate(true);
                  });

                  return Container(
                    width: width,
                    // height: height,
                    child: DropdownButtonFormField(
                      focusNode: focusNode,
                      items: menuItems
                          .map(
                            (item) => DropdownMenuItem(
                              child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: dropdownColor),
                                alignment: Alignment.center,
                                child: Text(item["text"], style: itemStyle),
                              ),
                              value: item["value"],
                            ),
                          )
                          .toList(),
                      selectedItemBuilder: (BuildContext context) {
                        return menuItems.map<Widget>((item) {
                          return ClipRect(
                            child: Container(
                              width: width,
                              height: height,
                              decoration: BoxDecoration(
                                color: fillColor,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: border.isUniform ? BorderRadius.circular(borderRadius) : null,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: contentHorizontalPadding, vertical: contentVerticalPadding),
                              alignment: Alignment.center,
                              child: Text(
                                item["text"],
                                style: selectedItemStyle,
                              ),
                            ),
                          );
                        }).toList();
                      },
                      elevation: 0,
                      dropdownColor: Colors.transparent,
                      hint: Text(hintText, style: hintStyle),
                      isDense: false,
                      isExpanded: false,
                      value: customDropDownFormFieldProvider.value,
                      iconSize: 0,
                      iconEnabledColor: Colors.transparent,
                      iconDisabledColor: Colors.transparent,
                      onChanged: (value) {
                        onChangeHandler(value);
                        customDropDownFormFieldProvider.setValue(value);
                        state.didChange(value);
                      },
                    ),
                  );
                },
              ),
            );
          },
        );
}

class KeicyDropDownFormFieldProvider extends ChangeNotifier {
  static KeicyDropDownFormFieldProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<KeicyDropDownFormFieldProvider>(context, listen: listen);

  KeicyDropDownFormFieldProvider(value) {
    _value = value;
  }

  dynamic _value;
  dynamic get value => _value;
  void setValue(dynamic value) {
    if (_value != value) {
      _value = value;
    }
  }

  bool _isDoneValidate = false;
  bool get isDoneValidate => _isDoneValidate;
  void setIsDoneValidate(bool isDoneValidate) {
    if (_isDoneValidate != isDoneValidate) {
      _isDoneValidate = isDoneValidate;
    }
  }
}
