import 'package:flutter/material.dart';
import '../services/ticket_service.dart';

class CheckoutScreen extends StatelessWidget {
  final String movieTitle;
  final String seat;

  const CheckoutScreen({super.key, required this.movieTitle, required this.seat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Pedido'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: const Text('Confirme os dados da sua compra:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            MergeSemantics(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Filme: $movieTitle', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Assento: $seat', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      const Text('Valor Total: R\$ 30,00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 54),
                ),
                onPressed: () async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Processando sua compra...'),
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.black87,
                    ),
                  );

                  await Future.delayed(const Duration(seconds: 1));

                  if (!context.mounted) return;

                  // 1. Gera um ID único baseado na hora atual
                  String idUnico = DateTime.now().millisecondsSinceEpoch.toString();
      
                  // 2. Monta os dados do ingresso
                  Map<String, dynamic> novoIngresso = {
                   'id': idUnico,
                   'movieTitle': movieTitle, // Puxa o nome do filme recebido na tela
                   'seat': seat,             // Puxa a poltrona recebida na tela
                   'date': DateTime.now().toIso8601String(),
                  };

                  await TicketService.salvarIngresso(novoIngresso);

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Compra Finalizada!'),
                        content: const Text('Bom filme! Seu ingresso digital foi gerado com sucesso.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            child: const Text('Voltar ao Início'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Confirmar Compra', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}