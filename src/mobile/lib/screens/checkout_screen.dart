import 'package:flutter/material.dart';

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
            const Text('Confirme os dados da sua compra:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Filme: $movieTitle', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Assento: $seat', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    // Usando barra invertida para escapar o cifrão
                    const Text('Valor Total: R\$ 30,00', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
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
                child: const Text('Confirmar Compra', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
