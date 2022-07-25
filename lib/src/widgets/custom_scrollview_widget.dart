import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ge0tic/src/utils/utils.dart';

class CustomScrollViewWidget extends StatelessWidget {
  final Color colorFondo;
  final String imagenFondo;
  final String titulo;
  final SliverList silverList;

  const CustomScrollViewWidget(
      {Key? key,
      required this.colorFondo,
      required this.imagenFondo,
      required this.titulo,
      required this.silverList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: colorFondo, // Color(0xFF921C30),
          foregroundColor: Colors.white,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  height: 400.0),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    var rng = Random();
                    int x = rng.nextInt(30);
                    String pathImage = 'assets/img/fondos$x.png';
                    return FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: AssetImage(pathImage),
                        image: AssetImage(pathImage));
                  },
                );
              }).toList(),
            ),
            title: Utils.estiloTexto(titulo, 16, true, Colors.white),
            centerTitle: true,
          ),
        ),
        silverList,
      ],
    );
  }
}
