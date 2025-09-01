import 'package:flutter/material.dart';

class NavDestination {
  final String label;
  final IconData icon;

  const NavDestination({required this.label, required this.icon});
}

final navDestinations = [
  NavDestination(label: 'Posts', icon: Icons.poll_sharp),
  NavDestination(label: 'Stream', icon: Icons.podcasts),
];
