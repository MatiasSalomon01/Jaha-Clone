import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

final List<Model> busesData = [
  Model(title: '23', subTitle: 'LAMBARE S.A.', isFavorite: true),
  Model(title: '2', subTitle: 'SMTC S.R.L.', isFavorite: true),
  Model(title: '13', subTitle: 'DE LA CONQUISTA S.A.', isFavorite: true),
  Model(title: '30', subTitle: 'VANGUARDIA S.A.C.I.', isFavorite: false),
  Model(title: '454', subTitle: '3 DE FEBRERO S.A.', isFavorite: false),
  Model(
      title: '1',
      subTitle: 'EMPRESA DE TRANSPORTE Y TU TRANSPORTE',
      isFavorite: false),
  Model(title: '5 CH', subTitle: 'LA CHAQUEÑA S.A.T.C', isFavorite: false),
  Model(title: '11', subTitle: 'GRUPO BENE S.A.', isFavorite: false),
  Model(title: '6', subTitle: 'POA RENDA SRL', isFavorite: false),
  Model(title: '15', subTitle: 'GUARANI S.A.C.I.', isFavorite: false),
];

final List<Model> cardData = [
  Model(
    title: 'Asociar Tarjeta',
    icon: FontAwesomeIcons.solidCreditCard,
    iconSize: 20,
  ),
  Model(
    title: 'Elminar Tarjeta',
    icon: FontAwesomeIcons.solidCreditCard,
    iconSize: 20,
  ),
  Model(
    title: 'Consultar Movimientos',
    icon: FontAwesomeIcons.coins,
    iconSize: 22,
  ),
];

final List<Model> personData = [
  Model(
    title: 'Mi Cuenta',
    icon: FontAwesomeIcons.userPen,
    iconSize: 20,
  ),
  Model(
    title: 'Preguntas Frecuentes',
    icon: FontAwesomeIcons.solidCircleQuestion,
    iconSize: 20,
  ),
  Model(
    title: 'Contacto',
    icon: FontAwesomeIcons.addressBook,
    iconSize: 22,
  ),
  Model(
    title: 'Acerca de Jaha GPS',
    icon: FontAwesomeIcons.circleInfo,
    iconSize: 22,
  ),
  Model(
    title: 'Promo Super Descuentos',
    icon: Icons.discount,
    iconSize: 22,
  ),
  Model(
    title: 'Novedades',
    icon: FontAwesomeIcons.newspaper,
    iconSize: 22,
  ),
  Model(
    title: 'Cerrar Sesión',
    icon: FontAwesomeIcons.rightFromBracket,
    iconSize: 22,
  ),
];
