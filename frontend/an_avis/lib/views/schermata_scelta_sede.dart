import 'package:an_avis/views/schermata_scelta_mese.dart';
import 'package:an_avis/widgets/pulsante_listview.dart';
import "package:flutter/material.dart";

class SchermataSceltaSede extends StatefulWidget {
  @override
  _SchermataSceltaSedeState createState() => _SchermataSceltaSedeState();
}

class _SchermataSceltaSedeState extends State<SchermataSceltaSede> {
  List<PulsanteListView> sediAvis = List<PulsanteListView>();
  TextEditingController controller = new TextEditingController();
  String filter;

  void _getSediAvis() {
    sediAvis.add(PulsanteListView(
        text: "Ancona",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Civitanova",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Macerata",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Tolentino",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Foligno",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Torino",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Milano",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Civitanova Alta",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Porto Potenza",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Camerino",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
    sediAvis.add(PulsanteListView(
        text: "Jesi",
        function: () => Navigator.pushNamed(context, "/sceltaMese")));
  }

  @override
  initState() {
    super.initState();
    _getSediAvis();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.red[900],
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        backgroundColor: Colors.blue[900],
        title: Text(
          "Scegli la sede in cui donare",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cerca sede",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0))),
              controller: controller,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sediAvis.length,
              itemBuilder: (BuildContext context, int index) {
                return filter == null || filter == ""
                    ? sediAvis[index]
                    : sediAvis[index]
                            .text
                            .toLowerCase()
                            .contains(filter.toLowerCase())
                        ? sediAvis[index]
                        : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
