import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_services.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  @override
  _Tab2PageState createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newServices = Provider.of<NewService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          _ListaCategorias(),
          Expanded(child: ListaNoticias(noticias: newServices.getArticulosCategoriaSeleccionada))
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final String nameCategorie = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5),
                Text('${nameCategorie[0].toUpperCase()}${nameCategorie.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;

  _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final categorySelected = Provider.of<NewService>(context).selectedCategory;

    return GestureDetector(
      onTap: () {
        // En los eventos los providers deben usar el listen: FALSE xq si no se produce errores.
        // SIempre solo en los eventos, para no redibujar
        final newServices = Provider.of<NewService>(context, listen: false);
        newServices.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.iconData,
          color: (categorySelected == this.categoria.name) ? miTema.accentColor : Colors.black54,
        ),
      ),
    );
  }
}
