import 'package:flutter/material.dart';
import 'package:mob_shop/paginas/lista_favoritos.dart';
import 'package:mob_shop/repositore/local_data/dao/produto_dao.dart';
import 'package:mob_shop/shared/componentes/dialog.dart';
import 'package:mob_shop/shared/componentes/progress.dart';

class BuscaFavoritos extends StatelessWidget {
  BuscaFavoritos() : super();
  @override
  Widget build(BuildContext context) {
    ProdutoDao produtoDao = ProdutoDao();
    return Scaffold(
      body: FutureBuilder(
        future: produtoDao.buscaFavoritos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListaFavoritos(snapshot.data);
                } else {
                  return ResponseDialog(
                      icon: Icons.error, message: 'Nenhum produto favoritado.');
                }
              }
          }
          return Progress();
        },
      ),
    );
  }
}
