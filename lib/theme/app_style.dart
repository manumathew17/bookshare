import 'package:bookshare/theme/colors.dart';
import 'package:flutter/material.dart';

const header = TextStyle(color: yellowPrimary, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 14.0);

const heading1 = TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0);

const heading1Bold = TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 10.0);

const infoText = TextStyle(color: Color(0xff909193), fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, fontSize: 10.0);

const header20 = TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 20.0);

const header12 = TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0);

const buttonText = TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.w600, fontStyle: FontStyle.normal, fontSize: 10);
const generalBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    boxShadow: [BoxShadow(color: Color(0x1f000000), offset: Offset(0, 2), blurRadius: 8, spreadRadius: 0)],
    color: Color(0xffffffff));

const inputDecoration = InputDecoration(
  label: Text(''),
  hintStyle: TextStyle(color: textGrey, fontWeight: FontWeight.w700, fontStyle: FontStyle.normal, fontSize: 12.0),
  border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(14))),
  filled: true,
  fillColor: textWhiteGrey,
);
