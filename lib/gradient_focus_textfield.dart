import 'dart:async';

import 'package:flutter/material.dart';

typedef StringCallback<T> = String? Function(String?);

class GradientFocusTextField extends StatefulWidget {
  final bool? readOnly;
  final int? maxLines;
  final int? minLines;
  final StringCallback? validator;
  final Widget? prefix;
  final IconData? suffixData;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final bool? hasBorder;
  final VoidCallback? onTap;
  final StringCallback? onChanged;
  final IconData? icondata;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final AutovalidateMode? autovalidateMode;
  final StringCallback? onFieldSubmitted;

  ///labelText cannot be used when hintText is used
  GradientFocusTextField(
      {Key? key,
      this.validator,
      this.hintText,
      this.obscureText = false,
      this.onTap,
      this.controller,
      this.readOnly = false,
      this.textInputAction = TextInputAction.done,
      this.textInputType,
      this.autovalidateMode,
      this.labelText,
      this.prefix,
      this.maxLines,
      this.icondata,
      this.hasBorder = false,
      this.suffixData,
      this.onFieldSubmitted,
      this.onChanged,
      this.minLines});

  @override
  _GradientFocusTextFieldState createState() => _GradientFocusTextFieldState();
}

class _GradientFocusTextFieldState extends State<GradientFocusTextField> {
  late bool hide;
  FocusNode _focus = FocusNode();

  StreamController<bool> gradientOnFocusController =
      StreamController<bool>.broadcast();

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(17),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: primaryGradient,
    // border: Border.all(
    //   color: Colors.white,
    // ),
    borderRadius: BorderRadius.circular(18),
  );
  @override
  void initState() {
    super.initState();
    hide = widget.obscureText ?? false;

    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    gradientOnFocusController.close();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    // setState(() {});
    gradientOnFocusController.add(_focus.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          widget.icondata != null ? Icon(widget.icondata) : Container(),
          widget.icondata != null
              ? SizedBox(
                  width: 16,
                )
              : Container(),
          Expanded(
            child: Stack(
              children: [
                StreamBuilder<Object>(
                    stream: gradientOnFocusController.stream,
                    builder: (context, snapshot) {
                      return Container(
                        margin: const EdgeInsets.all(1),
                        decoration: snapshot.data == true
                            ? kGradientBoxDecoration
                            : kInnerDecoration,
                        height: 70,
                      );
                    }),
                Container(
                  margin: const EdgeInsets.all(2),
                  child: Container(
                    height: 68,
                    decoration: kInnerDecoration,
                    // color: _focus.hasFocus ? Colors.green : Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          widget.labelText != null
                              ? StreamBuilder<Object>(
                                  stream: gradientOnFocusController.stream,
                                  builder: (context, snapshot) {
                                    return snapshot.data == true
                                        ? Text(
                                            widget.labelText!,
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff62758B)),
                                          )
                                        : SizedBox.shrink();
                                  })
                              : SizedBox.shrink(),
                          Expanded(
                            child: TextFormField(
                              autocorrect: false,
                              focusNode: _focus,
                              enableSuggestions: false,
                              autovalidateMode: widget.autovalidateMode,
                              keyboardType: widget.textInputType,
                              textInputAction: widget.textInputAction,
                              readOnly: widget.readOnly!,
                              controller: widget.controller,
                              onTap: widget.onTap,
                              obscureText: hide,
                              minLines: widget.minLines ?? null,
                              onFieldSubmitted: widget.onFieldSubmitted,
                              maxLines: widget.maxLines ?? 1,
                              validator: widget.validator,
                              onChanged: widget.onChanged ?? widget.onChanged,
                              decoration: InputDecoration(
                                prefixIcon: widget.prefix,
                                isDense: false,
                                suffixIcon: widget.obscureText!
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hide = !hide;
                                          });
                                        },
                                        icon: !hide
                                            ? Icon(
                                                Icons.visibility_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )
                                            : Icon(
                                                Icons.visibility_off_outlined,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                      )
                                    : widget.suffixData != null
                                        ? Icon(
                                            widget.suffixData,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : null,
                                // filled: true,
                                // labelText: widget.labelText,
                                hintText: widget.hintText,
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor),
                                // fillColor: Color(0xffD8D8D8).withOpacity(.3),
                                enabledBorder: widget.hasBorder!
                                    ? OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(.5)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      )
                                    : InputBorder.none,
                                border: widget.hasBorder!
                                    ? OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      )
                                    : InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


var primaryGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
  colors: <Color>[
    Color(0xff501EFF),
    Color(0xffF6B3BE),
    Color(0xff501EFF),
  ],
);