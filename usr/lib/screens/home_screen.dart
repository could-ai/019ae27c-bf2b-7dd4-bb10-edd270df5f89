import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/service_card.dart';
import '../widgets/registration_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isRegistered = false;
  String? _userName;

  @override
  void initState() {
    super.initState();
    // Simulate checking registration status on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRegistrationAlert();
    });
  }

  void _showRegistrationAlert() {
    if (!_isRegistered) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => RegistrationDialog(
          onRegistered: (name) {
            setState(() {
              _isRegistered = true;
              _userName = name;
            });
          },
        ),
      );
    }
  }

  void _handleServiceTap(ServiceModel service) {
    if (!_isRegistered) {
      _showRegistrationAlert();
    } else {
      // Navigate to service detail
      Navigator.pushNamed(context, service.route, arguments: service);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Sanchar Saathi', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Dept of Telecommunications, Govt of India',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white70),
            ),
          ],
        ),
        actions: [
          if (_isRegistered)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _userName != null && _userName!.isNotEmpty ? _userName![0].toUpperCase() : 'U',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.shield_moon, size: 64, color: Colors.white),
                  const SizedBox(height: 16),
                  Text(
                    'Empowering Mobile Subscribers',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Strengthening security and increasing awareness about citizen centric initiatives.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Citizen Services',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppConstants.services.length,
                    itemBuilder: (context, index) {
                      return ServiceCard(
                        service: AppConstants.services[index],
                        onTap: () => _handleServiceTap(AppConstants.services[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
