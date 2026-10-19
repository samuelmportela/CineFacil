import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/ticket_service.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  List<Map<String, dynamic>> _ingressos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarIngressos(); // Carrega os dados assim que a tela abre
  }

  // Função para RECUPERAR os dados do armazenamento local
  Future<void> _carregarIngressos() async {
    final ingressos = await TicketService.obterIngressos();
    setState(() {
      _ingressos = ingressos;
      _carregando = false;
    });
  }

  // Função para REMOVER os dados do armazenamento local
  Future<void> _cancelarIngresso(String id) async {
    await TicketService.removerIngresso(id);
    _carregarIngressos(); // Atualiza a tela após apagar
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresso cancelado com sucesso.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Ingressos'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _ingressos.isEmpty
              ? const Center(child: Text('Você ainda não possui ingressos.'))
              : ListView.builder(
                  itemCount: _ingressos.length,
                  itemBuilder: (context, index) {
                    final ingresso = _ingressos[index];
                    // Os dados que vão formar o QR Code
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
                            // Aqui nós geramos o QR Code mágico!
                            QrImageView(
                              data: qrData,
                              version: QrVersions.auto,
                              size: 150.0,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () => _cancelarIngresso(ingresso['id']),
                              icon: const Icon(Icons.delete),
                              label: const Text('Cancelar Ingresso'),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}