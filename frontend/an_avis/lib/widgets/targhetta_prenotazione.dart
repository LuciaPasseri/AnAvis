import 'package:flutter/material.dart';

class TargettaPrenotazione extends StatelessWidget {
  TargettaPrenotazione({
    @required this.label,
    @required this.icon,
    @required this.jsonTag,
    @required this.edgeInsets1,
    @required this.edgeInsets2,
    @required this.data,
    @required this.isType,
  });

  final String label;
  final IconData icon;
  final String jsonTag;
  final EdgeInsets edgeInsets1;
  final EdgeInsets edgeInsets2;
  final dynamic data;
  final bool isType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: edgeInsets1,
      child: Row(
        children: <Widget>[
          Chip(
            padding: edgeInsets2,
            elevation: 6,
            backgroundColor: Colors.blue[900],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue[900], width: 2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            label: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Chip(
            elevation: 4,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blue[900], width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            label: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.blue[900],
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  !isType
                      ? data[jsonTag]
                      : data[jsonTag][0] +
                          data[jsonTag].substring(1).toLowerCase(),
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}