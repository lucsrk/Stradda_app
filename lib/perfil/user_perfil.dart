import 'package:flutter/material.dart';

class Perfil {

  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const Perfil({
      this.id,
      @required this.name,
      @required this.email,
      this.avatarUrl});

}