import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/ticket_provider.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Ingressos'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Consumer<TicketProvider>(
        builder: (context, ticketProvider, child) {
          if (ticketProvider.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (ticketProvider.ingressos.isEmpty) {
            return const Center(child: Text('Você ainda não possui ingressos.'));
          }

          return ListView.builder(
            itemCount: ticketProvider.ingressos.length,
            itemBuilder: (context, index) {
              final ingresso = ticketProvider.ingressos[index];
              final qrData = 'Filme: ${ingresso['movieTitle']} | Poltrona: ${ingresso['seat']}';

              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        ingresso['movieTitle'],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text('Poltrona: ${ingresso['seat']}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      QrImageView(
                        data: qrData,
                        version: QrVersions.auto,
                        size: 150.0,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          ticketProvider.removerIngresso(ingresso['id']);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Ingresso cancelado com sucesso.')),
                          );
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text('Cancelar Ingresso'),
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}