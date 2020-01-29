import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class HttpService {
  Future getCall(BuildContext context, String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text(
          "Errore nel caricamento dei dati",
          style: TextStyle(color: Colors.white, fontFamily: "Nunito"),
        ),
      ).show(context);
    }
  }

  Future postCall(BuildContext context, String url, var data) async {
    return http.post(
      Uri.parse(url),
      body: data,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
  }

  void postCallWithSnackBar(
      BuildContext context, String url, var data, String message) async {
    http.Response responsePost = await http.post(
      Uri.parse(url),
      body: data,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
    if (responsePost.statusCode == 200) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        messageText: Text(message,
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text("Errore nel salvataggio dei dati",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    }
  }

  Future putCall(
      BuildContext context, String url, var data) async {
    return http.put(
      Uri.parse(url),
      body: data,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
  }

  void putCallWithSnackBar(
      BuildContext context, String url, var data, String message) async {
    http.Response responsePut = await http.put(
      Uri.parse(url),
      body: data,
      headers: {
        "content-type": "application/json; charset=utf-8",
        "accept": "application/json; charset=utf-8",
      },
    );
    if (responsePut.statusCode == 200) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        messageText: Text(message,
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text("Errore nel salvataggio dei dati",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    }
  }

  void deleteCall(BuildContext context, String url, String message) async {
    http.Response responseDelete = await http.delete(url);
    if (responseDelete.statusCode == 200) {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        messageText: Text(message,
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        messageText: Text("Errore nella modifica dei dati",
            style: TextStyle(fontFamily: "Nunito", color: Colors.white)),
      ).show(context);
    }
  }
}
