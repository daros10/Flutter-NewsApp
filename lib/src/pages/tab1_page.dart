import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  _Tab1PageState createState() => _Tab1PageState();
}

//Mezclando el widget con AutomaticKeepAliveClientMixin se mantiene el estado de la pantalla
class _Tab1PageState extends State<Tab1Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewService>(context);
    return Scaffold(
      body: newsServices.headLines.length == 0
          ? Center(child: CircularProgressIndicator())
          : ListaNoticias(
              noticias: newsServices.headLines,
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
