import 'package:flutter/material.dart';

class ServiceModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String route;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
  });
}

class AppConstants {
  static const String appName = 'Sanchar Saathi';
  static const String appTagline = 'Citizen Centric Initiative of DoT';
  
  static final List<ServiceModel> services = [
    ServiceModel(
      id: 'chakshu',
      title: 'Chakshu',
      description: 'Report Suspected Fraud Communication (Call, SMS, WhatsApp)',
      icon: Icons.visibility,
      route: '/chakshu',
    ),
    ServiceModel(
      id: 'block_lost',
      title: 'Block Lost/Stolen Mobile',
      description: 'Trace and block lost mobile devices to prevent misuse',
      icon: Icons.phonelink_lock,
      route: '/block-mobile',
    ),
    ServiceModel(
      id: 'know_connections',
      title: 'Know Your Mobile Connections',
      description: 'Check mobile connections registered in your name',
      icon: Icons.sim_card,
      route: '/know-connections',
    ),
    ServiceModel(
      id: 'imei_check',
      title: 'Know Genuineness of Handset',
      description: 'Verify mobile handset using IMEI number',
      icon: Icons.qr_code_scanner,
      route: '/imei-check',
    ),
    ServiceModel(
      id: 'report_intl',
      title: 'Report Intl. Call with Indian No.',
      description: 'Report international calls received with +91 number',
      icon: Icons.call_end,
      route: '/report-intl',
    ),
  ];
}
