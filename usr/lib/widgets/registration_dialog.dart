import 'package:flutter/material.dart';

class RegistrationDialog extends StatefulWidget {
  final Function(String) onRegistered;

  const RegistrationDialog({super.key, required this.onRegistered});

  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;
  int _step = 0; // 0: Info, 1: Name Input, 2: Verification

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startRegistration() {
    setState(() {
      _step = 1;
    });
  }

  void _submitName() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _step = 2;
      });

      // Simulate SMS sending and verification delay
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        widget.onRegistered(_nameController.text);
        Navigator.of(context).pop();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration Successful! Device verified.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_step == 0) ...[
              const Icon(Icons.security, size: 48, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                'Registration Required',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'To access Sanchar Saathi services, we need to verify your device.\n\nThis will send a one-time SMS to DoT on 14522 to register your active mobile number.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startRegistration,
                  child: const Text('Proceed to Register'),
                ),
              ),
            ] else if (_step == 1) ...[
              Text(
                'Enter Your Name',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitName,
                  child: const Text('Verify & Register'),
                ),
              ),
            ] else if (_step == 2) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text(
                'Sending SMS to 14522...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Verifying device and fetching active numbers...',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
