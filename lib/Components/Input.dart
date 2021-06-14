import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

inputComponent(
    {controller,
    icono,
    label,
    onChanged,
    enableb = true,
    format,
    onSubmitted,
    focusNode,
    contentPadding,
    autofocus = false,
    style = 0,type}) {
  return TextField(
    keyboardType:type,
      style: style==0?null: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
      autofocus: autofocus,
      focusNode: focusNode,
      enabled: enableb,
      controller: controller,
      onChanged: onChanged,
      cursorColor: Colors.white,
      inputFormatters: format,
      onSubmitted: onSubmitted == null ? (onsub) {} : onSubmitted,
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        prefixIcon:  style == 2?null:style == 0 ? Icon(icono):
        style == 2?null:
        Container(
            padding: EdgeInsets.only(right: 10),
            child: Icon(icono, color: Colors.white)),
        border: style == 2?null: style == 0|| style == 1? OutlineInputBorder():InputBorder.none,
        labelStyle: GoogleFonts.lato(),
        labelText: style == 0 ? label : null,
        hintStyle:
            GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.bold),
        hintText: style == 0 ? null : label,
      ));
}
