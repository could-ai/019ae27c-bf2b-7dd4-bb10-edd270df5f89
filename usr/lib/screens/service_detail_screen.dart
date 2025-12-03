import 'package:flutter/material.dart';
import '../utils/constants.dart';

class GenericServiceScreen extends StatelessWidget {
  final ServiceModel service;

  const GenericServiceScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Row(
                children: [
                  Icon(service.icon, size: 40, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      service.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Form Placeholder
            Text(
              'Required Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            if (service.id == 'chakshu') ...[
              _buildChakshuForm(),
            ] else if (service.id == 'block_lost') ...[
              _buildBlockLostForm(),
            ] else if (service.id == 'know_connections') ...[
              _buildKnowConnectionsContent(),
            ] else if (service.id == 'imei_check') ...[
              _buildIMEICheckForm(),
            ] else ...[
              _buildGenericForm(),
            ],

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Request submitted successfully')),
                  );
                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChakshuForm() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Medium of Communication'),
          items: const [
            DropdownMenuItem(value: 'Call', child: Text('Call')),
            DropdownMenuItem(value: 'SMS', child: Text('SMS')),
            DropdownMenuItem(value: 'WhatsApp', child: Text('WhatsApp')),
          ],
          onChanged: (v) {},
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Category of Fraud'),
          items: const [
            DropdownMenuItem(value: 'Financial', child: Text('Financial Fraud')),
            DropdownMenuItem(value: 'Impersonation', child: Text('Impersonation')),
            DropdownMenuItem(value: 'Sextortion', child: Text('Sextortion')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (v) {},
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Suspected Mobile Number',
            prefixText: '+91 ',
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Description',
            alignLabelWithHint: true,
          ),
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload Screenshot/Evidence'),
        ),
      ],
    );
  }

  Widget _buildBlockLostForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Mobile Number 1'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Mobile Number 2 (Optional)'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'IMEI 1'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Device Brand'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Lost Place'),
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Police Complaint Number'),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload Police Complaint'),
        ),
      ],
    );
  }

  Widget _buildKnowConnectionsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mobile numbers registered in your name:'),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const Icon(Icons.sim_card),
                title: Text('+91 98765 4321$index'),
                subtitle: const Text('Active since 2023'),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text('Not My Number', style: TextStyle(color: Colors.red)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildIMEICheckForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Enter IMEI Number'),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            IconButton.filled(
              onPressed: () {},
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: 'Scan Barcode',
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Dial *#06# to get your device IMEI number.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildGenericForm() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Mobile Number'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextFormField(
          decoration: const InputDecoration(labelText: 'Details'),
          maxLines: 3,
        ),
      ],
    );
  }
}
